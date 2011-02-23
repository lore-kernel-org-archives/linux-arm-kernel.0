From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Feb 2011 15:57:29 +0900
Subject: [PATCH 1/5] ARM: S5PV310: Add missing GPYx banks.
In-Reply-To: <1297927527-1338-2-git-send-email-m.szyprowski@samsung.com>
References: <1297927527-1338-1-git-send-email-m.szyprowski@samsung.com>
	<1297927527-1338-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <01e301cbd326$f2bc5d40$d83517c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyrowski wrote:
> 
> This patch adds missing GPYx gpio banks on Samsung S5PC210 platform.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/gpiolib.c           |   49
> +++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv310/include/mach/gpio.h |   23 +++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/gpiolib.c b/arch/arm/mach-
> s5pv310/gpiolib.c
> index 55217b8..f417ecd 100644
> --- a/arch/arm/mach-s5pv310/gpiolib.c
> +++ b/arch/arm/mach-s5pv310/gpiolib.c
> @@ -199,6 +199,55 @@ static struct s3c_gpio_chip s5pv310_gpio_part2_4bit[]
=
> {
>  			.label	= "GPL2",
>  		},
>  	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV310_GPY0(0),
> +			.ngpio	= S5PV310_GPIO_Y0_NR,
> +			.label	= "GPY0",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV310_GPY1(0),
> +			.ngpio	= S5PV310_GPIO_Y1_NR,
> +			.label	= "GPY1",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV310_GPY2(0),
> +			.ngpio	= S5PV310_GPIO_Y2_NR,
> +			.label	= "GPY2",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV310_GPY3(0),
> +			.ngpio	= S5PV310_GPIO_Y3_NR,
> +			.label	= "GPY3",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV310_GPY4(0),
> +			.ngpio	= S5PV310_GPIO_Y4_NR,
> +			.label	= "GPY4",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV310_GPY5(0),
> +			.ngpio	= S5PV310_GPIO_Y5_NR,
> +			.label	= "GPY5",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV310_GPY6(0),
> +			.ngpio	= S5PV310_GPIO_Y6_NR,
> +			.label	= "GPY6",
> +		},
> +	}, {
>  		.base	= (S5P_VA_GPIO2 + 0xC00),
>  		.config	= &gpio_cfg_noint,
>  		.irq_base = IRQ_EINT(0),
> diff --git a/arch/arm/mach-s5pv310/include/mach/gpio.h b/arch/arm/mach-
> s5pv310/include/mach/gpio.h
> index 20cb80c..4b44463 100644
> --- a/arch/arm/mach-s5pv310/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv310/include/mach/gpio.h
> @@ -50,6 +50,13 @@
>  #define S5PV310_GPIO_X1_NR	(8)
>  #define S5PV310_GPIO_X2_NR	(8)
>  #define S5PV310_GPIO_X3_NR	(8)
> +#define S5PV310_GPIO_Y0_NR	(6)
> +#define S5PV310_GPIO_Y1_NR	(4)
> +#define S5PV310_GPIO_Y2_NR	(6)
> +#define S5PV310_GPIO_Y3_NR	(8)
> +#define S5PV310_GPIO_Y4_NR	(8)
> +#define S5PV310_GPIO_Y5_NR	(8)
> +#define S5PV310_GPIO_Y6_NR	(8)
>  #define S5PV310_GPIO_Z_NR	(7)
> 
>  /* GPIO bank numbers */
> @@ -87,7 +94,14 @@ enum s5p_gpio_number {
>  	S5PV310_GPIO_X1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X0),
>  	S5PV310_GPIO_X2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X1),
>  	S5PV310_GPIO_X3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X2),
> -	S5PV310_GPIO_Z_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X3),
> +	S5PV310_GPIO_Y0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X3),
> +	S5PV310_GPIO_Y1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_Y0),
> +	S5PV310_GPIO_Y2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_Y1),
> +	S5PV310_GPIO_Y3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_Y2),
> +	S5PV310_GPIO_Y4_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_Y3),
> +	S5PV310_GPIO_Y5_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_Y4),
> +	S5PV310_GPIO_Y6_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_Y5),
> +	S5PV310_GPIO_Z_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_Y6),
>  };
> 
>  /* S5PV310 GPIO number definitions */
> @@ -120,6 +134,13 @@ enum s5p_gpio_number {
>  #define S5PV310_GPX1(_nr)	(S5PV310_GPIO_X1_START + (_nr))
>  #define S5PV310_GPX2(_nr)	(S5PV310_GPIO_X2_START + (_nr))
>  #define S5PV310_GPX3(_nr)	(S5PV310_GPIO_X3_START + (_nr))
> +#define S5PV310_GPY0(_nr)	(S5PV310_GPIO_Y0_START + (_nr))
> +#define S5PV310_GPY1(_nr)	(S5PV310_GPIO_Y1_START + (_nr))
> +#define S5PV310_GPY2(_nr)	(S5PV310_GPIO_Y2_START + (_nr))
> +#define S5PV310_GPY3(_nr)	(S5PV310_GPIO_Y3_START + (_nr))
> +#define S5PV310_GPY4(_nr)	(S5PV310_GPIO_Y4_START + (_nr))
> +#define S5PV310_GPY5(_nr)	(S5PV310_GPIO_Y5_START + (_nr))
> +#define S5PV310_GPY6(_nr)	(S5PV310_GPIO_Y6_START + (_nr))
>  #define S5PV310_GPZ(_nr)	(S5PV310_GPIO_Z_START + (_nr))
> 
>  /* the end of the S5PV310 specific gpios */
> --

Ok...but as you know, need to re-work based on latest.
Could you re-submit this based on my for-next which includes Exynos4?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
