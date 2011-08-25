From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 11:49:22 +0200
Subject: [PATCH 3/6] mc13xxx: remove obsolete leds and regulators flags
In-Reply-To: <1311344232-29902-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-2-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-3-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20110825094922.GQ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 04:17:09PM +0200, Philippe R?tornaz wrote:
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  arch/arm/mach-imx/mach-mx27_3ds.c    |    1 -
>  arch/arm/mach-imx/mach-mx31_3ds.c    |    2 +-
>  arch/arm/mach-imx/mach-mx31lite.c    |    3 +--
>  arch/arm/mach-imx/mach-mx31moboard.c |    3 +--
>  arch/arm/mach-imx/mach-pcm038.c      |    3 +--
>  arch/arm/mach-mx5/mx51_efika.c       |    2 +-
>  6 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
> index 6e1accf..8cd507d 100644
> --- a/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -238,7 +238,6 @@ static struct mc13xxx_platform_data mc13783_pdata = {
>  		.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
>  
>  	},
> -	.flags  = MC13783_USE_REGULATOR,
>  };
>  
>  /* SPI */
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index 9b98244..7978f58 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -496,7 +496,7 @@ static struct mc13xxx_platform_data mc13783_pdata = {
>  		.regulators = mx31_3ds_regulators,
>  		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
>  	},
> -	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
> +	.flags  = MC13783_USE_TOUCHSCREEN,
>  };
>  
>  /* SPI */
> diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
> index ac9b4ca..ae99cae 100644
> --- a/arch/arm/mach-imx/mach-mx31lite.c
> +++ b/arch/arm/mach-imx/mach-mx31lite.c
> @@ -112,8 +112,7 @@ static const struct spi_imx_master spi1_pdata __initconst = {
>  };
>  
>  static struct mc13xxx_platform_data mc13783_pdata __initdata = {
> -	.flags  = MC13XXX_USE_RTC |
> -		  MC13XXX_USE_REGULATOR,
> +	.flags  = MC13XXX_USE_RTC,
>  };
>  
>  static struct spi_board_info mc13783_spi_dev __initdata = {
> diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
> index 12ee755..579ca1f 100644
> --- a/arch/arm/mach-imx/mach-mx31moboard.c
> +++ b/arch/arm/mach-imx/mach-mx31moboard.c
> @@ -270,8 +270,7 @@ static struct mc13xxx_platform_data moboard_pmic = {
>  		.num_regulators = ARRAY_SIZE(moboard_regulators),
>  	},
>  	.leds = &moboard_leds,
> -	.flags = MC13XXX_USE_REGULATOR | MC13XXX_USE_RTC |
> -		MC13XXX_USE_ADC | MC13XXX_USE_LED,
> +	.flags = MC13XXX_USE_RTC | MC13XXX_USE_ADC,
>  };
>  
>  static struct spi_board_info moboard_spi_board_info[] __initdata = {
> diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
> index 853bb87..70aaa7d 100644
> --- a/arch/arm/mach-imx/mach-pcm038.c
> +++ b/arch/arm/mach-imx/mach-pcm038.c
> @@ -266,8 +266,7 @@ static struct mc13xxx_platform_data pcm038_pmic = {
>  		.regulators = pcm038_regulators,
>  		.num_regulators = ARRAY_SIZE(pcm038_regulators),
>  	},
> -	.flags = MC13783_USE_ADC | MC13783_USE_REGULATOR |
> -		 MC13783_USE_TOUCHSCREEN,
> +	.flags = MC13783_USE_ADC | MC13783_USE_TOUCHSCREEN,
>  };
>  
>  static struct spi_board_info pcm038_spi_board_info[] __initdata = {
> diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
> index 1105ef3..e2e4096 100644
> --- a/arch/arm/mach-mx5/mx51_efika.c
> +++ b/arch/arm/mach-mx5/mx51_efika.c
> @@ -567,7 +567,7 @@ static struct mc13xxx_regulator_init_data mx51_efika_regulators[] = {
>  };
>  
>  static struct mc13xxx_platform_data mx51_efika_mc13892_data = {
> -	.flags = MC13XXX_USE_RTC | MC13XXX_USE_REGULATOR,
> +	.flags = MC13XXX_USE_RTC,
>  	.regulators = {
>  		.num_regulators = ARRAY_SIZE(mx51_efika_regulators),
>  		.regulators = mx51_efika_regulators,
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
