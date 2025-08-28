terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Get Amazon Linux 2 AMI
data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Jenkins server
resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amzn2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "jenkins-server"
  }
}

# App server
resource "aws_instance" "app" {
  ami           = data.aws_ami.amzn2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "app-server"
  }
}
