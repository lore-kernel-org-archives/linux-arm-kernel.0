From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Aug 2012 16:44:47 -0700
Subject: [PATCH 1/3] ARM: EXYNOS: Use EXYNOS4210_GPEx instead of
 EXYNOS4_GPEx
In-Reply-To: <14029212.D3MKvQZpbq@amdc1227>
References: <4648723.rWnut7F0uJ@amdc1227> <14029212.D3MKvQZpbq@amdc1227>
Message-ID: <503D57EF.2090402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/12 03:06, Tomasz Figa wrote:
> The GPEx gpios are specific to Exynos4210 and do not exist on Exynos4x12.
> Redefine them to use the exact SoC name.
>
> Based on "ARM: EXYYNOS: Use EXYNOS4210_GPEx instead of EXYNOS4_GPEx" by
> Joonyoung Shim, see:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/100738.html
>
> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
> ---
>   arch/arm/mach-exynos/include/mach/gpio.h   | 32 +++++++++++++++---------------
>   arch/arm/mach-exynos/mach-nuri.c           | 16 +++++++--------
>   arch/arm/mach-exynos/mach-origen.c         |  6 +++---
>   arch/arm/mach-exynos/mach-trats.c          |  4 ++--
>   arch/arm/mach-exynos/mach-universal_c210.c | 32 +++++++++++++++---------------
>   arch/arm/mach-exynos/setup-fimc.c          |  4 ++--
>   drivers/gpio/gpio-samsung.c                | 20 +++++++++----------
>   7 files changed, 57 insertions(+), 57 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
> index eb24f1e..21c9bf1 100644
> --- a/arch/arm/mach-exynos/include/mach/gpio.h
> +++ b/arch/arm/mach-exynos/include/mach/gpio.h
> @@ -26,11 +26,11 @@
>   #define EXYNOS4_GPIO_C1_NR	(5)
>   #define EXYNOS4_GPIO_D0_NR	(4)
>   #define EXYNOS4_GPIO_D1_NR	(4)
> -#define EXYNOS4_GPIO_E0_NR	(5)
> -#define EXYNOS4_GPIO_E1_NR	(8)
> -#define EXYNOS4_GPIO_E2_NR	(6)
> -#define EXYNOS4_GPIO_E3_NR	(8)
> -#define EXYNOS4_GPIO_E4_NR	(8)
> +#define EXYNOS4210_GPIO_E0_NR	(5)
> +#define EXYNOS4210_GPIO_E1_NR	(8)
> +#define EXYNOS4210_GPIO_E2_NR	(6)
> +#define EXYNOS4210_GPIO_E3_NR	(8)
> +#define EXYNOS4210_GPIO_E4_NR	(8)

Please see my comments on Joonyoung Shim's previous patch...
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101522.html

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
