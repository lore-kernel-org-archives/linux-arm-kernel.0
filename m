From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Dec 2011 19:30:13 +0900
Subject: [PATCH] ARM: S3C64XX: Add linux/export.h to dev-spi.c
In-Reply-To: <1322490819-18971-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322490819-18971-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <047401ccb014$358b7c30$a0a27490$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> This is required for the EXPORT_SYMBOL()s the code uses, previously the
> header was being included implicitly by another header.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/dev-spi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-
> spi.c
> index 86fb130..3f437e7 100644
> --- a/arch/arm/mach-s3c64xx/dev-spi.c
> +++ b/arch/arm/mach-s3c64xx/dev-spi.c
> @@ -10,6 +10,7 @@
> 
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> +#include <linux/export.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/gpio.h>
> --
> 1.7.7.3

Right, will apply for v3.2.

But since Padmavathi's SPI consolidation patches removes dev-spi.c files so
this can be dropped for v3.3, and as a note, I will look at other patches
tomorrow :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
