#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-2df66d3b
#
# Your subnet ID is:
#
#     subnet-fe40a9a4
#
# Your security group ID is:
#
#     sg-4cc10432
#
# Your Identity is:
#
#     testing-rat
#

terraform {
  backend "atlas" {
    name = "xfrarod/training"
  }
}

variable "num_webs" {
  default = "2"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  instance_type          = "t2.micro"
  ami                    = "ami-2df66d3b"
  subnet_id              = "subnet-fe40a9a4"
  vpc_security_group_ids = ["sg-4cc10432"]

  tags {
    "Name" = "web"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
