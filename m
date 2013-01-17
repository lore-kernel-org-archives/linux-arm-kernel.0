From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 16 Jan 2013 16:06:13 -0800
Subject: [PATCH] ARM: S3C64XX: Fix up IRQ mapping for balblair on
 Cragganmore
In-Reply-To: <1358016152-5056-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1358016152-5056-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <0c0201cdf446$77d30aa0$67791fe0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> 
> We are using S3C_EINT(4) instead of S3C_EINT(5).
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> index 553059f..755c0bb 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -47,7 +47,7 @@ static struct spi_board_info wm1253_devs[] = {
>  		.bus_num	= 0,
>  		.chip_select	= 0,
>  		.mode		= SPI_MODE_0,
> -		.irq		= S3C_EINT(5),
> +		.irq		= S3C_EINT(4),
>  		.controller_data = &wm0010_spi_csinfo,
>  		.platform_data = &wm0010_pdata,
>  	},
> --
> 1.7.10.4

Applied, thanks.

- Kukjin
