From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 Aug 2010 22:33:28 +0900
Subject: [PATCH 2/3] ARM: S5PC210: Add missing GPIO MP0_0 definition
In-Reply-To: <20100806042351.GA19437@july>
References: <20100806042351.GA19437@july>
Message-ID: <00b201cb356b$f75310a0$e5f931e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Some board uses the MP0_0 for GPIO.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/include/mach/gpio.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/include/mach/gpio.h b/arch/arm/mach-
> s5pv310/include/mach/gpio.h
> index a840d83..4ab4e23 100644
> --- a/arch/arm/mach-s5pv310/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv310/include/mach/gpio.h
> @@ -55,6 +55,7 @@
>  #define S5PV310_GPIO_X2_NR	(8)
>  #define S5PV310_GPIO_X3_NR	(8)
>  #define S5PV310_GPIO_Z_NR	(7)
> +#define S5PV310_GPIO_MP00_NR	(8)
>  #define S5PV310_GPIO_MP01_NR	(8)
>  #define S5PV310_GPIO_MP02_NR	(4)
>  #define S5PV310_GPIO_MP03_NR	(8)
> @@ -96,7 +97,8 @@ enum s5p_gpio_number {
>  	S5PV310_GPIO_X2_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_X1),
>  	S5PV310_GPIO_X3_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_X2),
>  	S5PV310_GPIO_Z_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X3),
> -	S5PV310_GPIO_MP01_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_Z),
> +	S5PV310_GPIO_MP00_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_Z),
> +	S5PV310_GPIO_MP01_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_MP00),
>  	S5PV310_GPIO_MP02_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_MP01),
>  	S5PV310_GPIO_MP03_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_MP02),
>  	S5PV310_GPIO_MP04_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_MP03),
> @@ -133,6 +135,7 @@ enum s5p_gpio_number {
>  #define S5PV310_GPX2(_nr)	(S5PV310_GPIO_X2_START + (_nr))
>  #define S5PV310_GPX3(_nr)	(S5PV310_GPIO_X3_START + (_nr))
>  #define S5PV310_GPZ(_nr)	(S5PV310_GPIO_Z_START + (_nr))
> +#define S5PV310_MP00(_nr)	(S5PV310_GPIO_MP00_START + (_nr))
>  #define S5PV310_MP01(_nr)	(S5PV310_GPIO_MP01_START + (_nr))
>  #define S5PV310_MP02(_nr)	(S5PV310_GPIO_MP02_START + (_nr))
>  #define S5PV310_MP03(_nr)	(S5PV310_GPIO_MP03_START + (_nr))
> --

Should be merged previous '[PATCH] ARM: S5PC210: Define more GPIOs to use
the MP pins' and this.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
