# Datasources
data "aws_availability_zones" "available" {
  state = "available"
}

# # Locals Block
# locals {
#   azs             = slice(data.aws_availability_zones.available.names, 0, 3)
#   public_subnets  = [for k, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbits, k)]
#   private_subnets = [for k, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbits, k + 10)]
# }


locals {
  # 1. Define AZs (Slicing the first 3)
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  # 2. Public Subnets (0, 1, 2)
  # range(3) creates a list [0, 1, 2]
  public_subnets = [for i in range(length(local.azs)) : cidrsubnet(var.vpc_cidr, var.subnet_newbits, i)]

  # 3. Private Subnets (10, 11, 12)
  # We just add the offset (+ 10) to the iterator 'i'
  private_subnets = [for i in range(length(local.azs)) : cidrsubnet(var.vpc_cidr, var.subnet_newbits, i + 10)]
}