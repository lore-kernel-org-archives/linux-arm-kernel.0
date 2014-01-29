From: jilin@nvidia.com (Jim Lin)
Date: Wed, 29 Jan 2014 10:26:18 +0800
Subject: [PATCH v3 3/6] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1390952176-30402-4-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <1390952176-30402-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1390962378.2398.11.camel@jilin-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-29 at 07:36 +0800, Peter De Schrijver wrote:
> Implement fuse driver for Tegra20, Tegra30, Tegra114 and Tegra124.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-tegra-fuse |    8 +
>  drivers/misc/fuse/Makefile                        |    1 +
>  drivers/misc/fuse/tegra/Makefile                  |    7 +
>  drivers/misc/fuse/tegra/fuse-tegra.c              |  228 ++++++++++++++++
>  drivers/misc/fuse/tegra/fuse-tegra20.c            |  136 ++++++++++
>  drivers/misc/fuse/tegra/fuse-tegra30.c            |  178 +++++++++++++
>  drivers/misc/fuse/tegra/fuse.h                    |   82 ++++++
Could we move this fuse.h to other folder under /include/linux
(like /include/linux/platform_data)
for other driver to include?
So other driver can invoke function to read fuse data if needed.

--nvpublic
