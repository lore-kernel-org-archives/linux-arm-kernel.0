From: koro.chen@mediatek.com (Koro Chen)
Date: Thu, 14 Jan 2016 09:43:15 +0800
Subject: [alsa-devel] [PATCH] ASoC: mediatek: add i2c dependency
In-Reply-To: <5346380.rqT2CVl4PH@wuerfel>
References: <5346380.rqT2CVl4PH@wuerfel>
Message-ID: <1452735795.28205.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-13 at 23:14 +0100, Arnd Bergmann wrote:
> The newly added mediatek drivers for mt8173 select codes that depend
> on I2C, which cuases a build failure if I2C is disabled:
> 
> warning: (SND_SOC_ADAU1761_I2C && SND_SOC_ADAU1781_I2C && SND_SOC_ADAU1977_I2C && SND_SOC_RT5677 && EXTCON_MAX14577 && EXTCON_MAX77693 && EXTCON_MAX77843 && BMC150_ACCEL_I2C && BMG160_I2C) selects REGMAP_I2C which has unmet direct dependencies (I2C)
> codecs/rt5645.c:3854:1: warning: data definition has no type or storage class
> codecs/rt5645.c:3854:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> codecs/rt5677.c:5270:1: warning: data definition has no type or storage class
> 77_i2c_driver);
> 
> codecs/rt5677.c:5270:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> 
> This adds an explicit dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 15c04e2eae34..976967675387 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -9,7 +9,7 @@ config SND_SOC_MEDIATEK
>  
>  config SND_SOC_MT8173_MAX98090
>  	tristate "ASoC Audio driver for MT8173 with MAX98090 codec"
> -	depends on SND_SOC_MEDIATEK
> +	depends on SND_SOC_MEDIATEK && I2C
>  	select SND_SOC_MAX98090
>  	help
>  	  This adds ASoC driver for Mediatek MT8173 boards
> @@ -19,7 +19,7 @@ config SND_SOC_MT8173_MAX98090
>  
>  config SND_SOC_MT8173_RT5650_RT5676
>  	tristate "ASoC Audio driver for MT8173 with RT5650 RT5676 codecs"
> -	depends on SND_SOC_MEDIATEK
> +	depends on SND_SOC_MEDIATEK && I2C
>  	select SND_SOC_RT5645
>  	select SND_SOC_RT5677
>  	help
> 
Acked-by: Koro Chen <koro.chen@mediatek.com>

Thank you!

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
