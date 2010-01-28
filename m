From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Jan 2010 10:02:39 +0100
Subject: [PATCHv2] ARM: S3C64XX: SPI: Make platform device compilation
	selectable
In-Reply-To: <1264666489-24789-1-git-send-email-jassisinghbrar@gmail.com>
References: <1264666489-24789-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100128090239.GD13756@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 28, 2010 at 05:14:49PM +0900, jassisinghbrar at gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The SPI controller platform devices should be compiled in
> independent of the driver support, otherwise we might end
> up with dev-spi built as kernel module.
> Change this to make every machine select if it has some SPI
> device and wants to build device definitions.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/Makefile |    4 +++-
>  arch/arm/plat-samsung/Kconfig  |    6 ++++++
>  2 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
> index 80255a5..e60bde3 100644
> --- a/arch/arm/plat-s3c64xx/Makefile
> +++ b/arch/arm/plat-s3c64xx/Makefile
> @@ -40,6 +40,9 @@ obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
>  
>  obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
>  
> +# SPI support
> +obj-$(CONFIG_S3C64XX_DEV_SPI) += dev-spi.o
> +
>  # Device setup
>  
>  obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
> @@ -47,4 +50,3 @@ obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
>  obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
>  obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
>  obj-$(CONFIG_SND_S3C24XX_SOC) += dev-audio.o
> -obj-$(CONFIG_SPI_S3C64XX) += dev-spi.o
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 1c2fe91..72da646 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -132,6 +132,12 @@ config S3C_DEV_NAND
>  	help
>  	  Compile in platform device definition for NAND controller
>  
> +config S3C64XX_DEV_SPI
> +	bool
> +	help
> +	  Compile in platform device definitions for S3C64XX's type
> +	  SPI controllers.
> +
>  comment "Power management"
>  
>  config SAMSUNG_PM_DEBUG
Is it correct that S3C64XX_DEV_SPI for now is always unselected and so
dev-spi.o is never compiled?  Assuming there are already machines using
it the corresponding symbols should select S3C64XX_DEV_SPI, don't they?

If that's wrong the last sentence in your commit log is confusing.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
