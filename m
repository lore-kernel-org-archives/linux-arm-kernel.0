From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 22 Jun 2010 10:45:23 +0900
Subject: [PATCH v4] libata: pata_samsung_cf: Add Samsung PATA controller
	driver
In-Reply-To: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
References: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <010c01cb11ac$9844e490$c8ceadb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> From: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE
subsystem.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---

Hi,

Maybe missed? :-(

If no problems, please apply or kindly let me know how this should be
handled.

> 
> Changes since v3:
> 
> Addressed comments from
> 
> Sergei Shtylyov:
> 	- Removed filename in header
> 	- Used ata_timing_compute for obtaining timing parameters
> 	- Removed valid PIO mode check
> 	- Added softreset method and associated functions
> 	- Used devm_request_mem_region function as had used devm_ioremap
> 	  earlier
> 	- Removed kree and release_mem_region calls because of managed
> 	  kzalloc and request_mem_region fns being used
> 	- Added return in clk_get function
> 	- Added missing clk_put
> 	- Corrected indentation issue
> 
> Ben Dooks:
> 	- Added missing 'void __iomem' parameters
> 	- Added check for trailing bytes in data_xfer function
> 	- Removed assignment in data_xfer function
> 	- Coding changes - e.g. in pata_s3c_enable, pata_s3c_dev_select,
> 	  wait_for_host_ready
> 	- Removed host checks in suspend/resume functions
> 
>  drivers/ata/Kconfig           |    9 +
>  drivers/ata/Makefile          |    1 +
>  drivers/ata/pata_samsung_cf.c |  735
> +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 745 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_samsung_cf.c
> 
(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
