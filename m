From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 21 Jan 2010 01:48:48 +0000
Subject: [PATCH] S3C64XX: Fix dev-audio build
In-Reply-To: <1263989155-7075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1263989155-7075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100121014848.GZ10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 12:05:55PM +0000, Mark Brown wrote:
> As reported when the patch was posted commit 71269364 ("ARM: S3C64XX:
> Add I2S resources in platform code") uses pin names for the IISv4
> data output pins which are not present in mainline, causing dev-audio
> to fail to build. Fix this by using the defines which are actually
> present in the kernel source.

applied to next-samsung-s3c64xx2, etc.
 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-s3c64xx/dev-audio.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
> index cdba3a7..5b89344 100644
> --- a/arch/arm/plat-s3c64xx/dev-audio.c
> +++ b/arch/arm/plat-s3c64xx/dev-audio.c
> @@ -51,9 +51,9 @@ static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
>  
>  static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
>  {
> -	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S0_V40_DO);
> -	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S1_V40_DO);
> -	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S2_V40_DO);
> +	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
> +	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
> +	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
>  	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
>  	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
>  	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
> -- 
> 1.6.6
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
