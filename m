From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Aug 2010 18:59:01 +0900
Subject: [PATCH] ARM: S5PC210: Define more GPIOs to use the MP pins
In-Reply-To: <20100802113521.GA1107@july>
References: <20100802113521.GA1107@july>
Message-ID: <00d601cb404e$55dc2a70$01947f50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
Hi ;-)

> Note that these pins can't support the interrupt. Only use to
input/output.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/include/mach/gpio.h |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/include/mach/gpio.h b/arch/arm/mach-
> s5pv310/include/mach/gpio.h
> index 3f751f2..a840d83 100644
> --- a/arch/arm/mach-s5pv310/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv310/include/mach/gpio.h
> @@ -55,6 +55,10 @@
>  #define S5PV310_GPIO_X2_NR	(8)
>  #define S5PV310_GPIO_X3_NR	(8)
>  #define S5PV310_GPIO_Z_NR	(7)

MP00 ?

> +#define S5PV310_GPIO_MP01_NR	(8)

Should be 4.

> +#define S5PV310_GPIO_MP02_NR	(4)

Should be 6.

> +#define S5PV310_GPIO_MP03_NR	(8)
> +#define S5PV310_GPIO_MP04_NR	(8)
> 
>  /* GPIO bank numbers */
> 
> @@ -92,6 +96,10 @@ enum s5p_gpio_number {
>  	S5PV310_GPIO_X2_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_X1),
>  	S5PV310_GPIO_X3_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_X2),
>  	S5PV310_GPIO_Z_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X3),
> +	S5PV310_GPIO_MP01_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_Z),
> +	S5PV310_GPIO_MP02_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_MP01),
> +	S5PV310_GPIO_MP03_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_MP02),
> +	S5PV310_GPIO_MP04_START	=
> S5PV310_GPIO_NEXT(S5PV310_GPIO_MP03),
>  };
> 
>  /* S5PV310 GPIO number definitions */
> @@ -125,9 +133,13 @@ enum s5p_gpio_number {
>  #define S5PV310_GPX2(_nr)	(S5PV310_GPIO_X2_START + (_nr))
>  #define S5PV310_GPX3(_nr)	(S5PV310_GPIO_X3_START + (_nr))
>  #define S5PV310_GPZ(_nr)	(S5PV310_GPIO_Z_START + (_nr))
> +#define S5PV310_MP01(_nr)	(S5PV310_GPIO_MP01_START + (_nr))
> +#define S5PV310_MP02(_nr)	(S5PV310_GPIO_MP02_START + (_nr))
> +#define S5PV310_MP03(_nr)	(S5PV310_GPIO_MP03_START + (_nr))
> +#define S5PV310_MP04(_nr)	(S5PV310_GPIO_MP04_START + (_nr))
> 
>  /* the end of the S5PV310 specific gpios */
> -#define S5PV310_GPIO_END	(S5PV310_GPZ(S5PV310_GPIO_Z_NR) + 1)
> +#define S5PV310_GPIO_END	(S5PV310_MP04(S5PV310_GPIO_MP04_NR) +
> 1)
>  #define S3C_GPIO_END		S5PV310_GPIO_END
> 
>  /* define the number of gpios we need to the one after the GPZ() range */

Should be MP04() in comment.
And...ARCH_NR_GPIOS should be changed together.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
