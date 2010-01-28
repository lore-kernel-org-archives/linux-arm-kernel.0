From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 28 Jan 2010 08:05:26 +0000
Subject: [PATCH] ARM: S3C64XX: SPI: Make platform device build selectable
In-Reply-To: <1264663530-30027-1-git-send-email-jassisinghbrar@gmail.com>
References: <1264663530-30027-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100128080525.GT10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 04:25:30PM +0900, jassisinghbrar at gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The SPI controller platform devices should be compiled in independent of 
> the driver support, otherwise we might end up with dev-spi built as kernel
> module.
> Change this to make every machine select if it has some SPI device and wants
> to build in SPI platform device definitions.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/Makefile |    2 +-
>  arch/arm/plat-samsung/Kconfig  |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
> index 80255a5..9838550 100644
> --- a/arch/arm/plat-s3c64xx/Makefile
> +++ b/arch/arm/plat-s3c64xx/Makefile
> @@ -47,4 +47,4 @@ obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
>  obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
>  obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
>  obj-$(CONFIG_SND_S3C24XX_SOC) += dev-audio.o
> -obj-$(CONFIG_SPI_S3C64XX) += dev-spi.o
> +obj-$(CONFIG_S3C_DEV_SPI) += dev-spi.o
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 1c2fe91..2220187 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -132,6 +132,11 @@ config S3C_DEV_NAND
>  	help
>  	  Compile in platform device definition for NAND controller
>  
> +config S3C_DEV_SPI

I'd prefer to see this as either S3C64XX_DEV_SPI or S3C_DEV_HSSPI to
differentiate it from the older S3C24XX SPI blocks.

> +	bool
> +	help
> +	  Compile in platform device definition for SPI controller
> +
>  comment "Power management"
>  
>  config SAMSUNG_PM_DEBUG
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
