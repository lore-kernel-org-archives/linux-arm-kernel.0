From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 10 Dec 2012 11:16:08 +0900
Subject: [PATCH] ARM: EXYNOS: fix GIC using for EXYNOS5440
In-Reply-To: <030c01cdd672$cb1b6b40$615241c0$%kim@samsung.com>
References: <030c01cdd672$cb1b6b40$615241c0$%kim@samsung.com>
Message-ID: <50C545E8.8050301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/10/2012 10:07 AM, Kukjin Kim wrote:
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>   arch/arm/mach-exynos/common.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 0eb3b9a..9ecda37 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -684,7 +684,8 @@ void __init exynos5_init_irq(void)
>   	 * Theses parameters should be NULL and 0 because EXYNOS4
>   	 * uses GIC instead of VIC.
>   	 */
> -	s5p_init_irq(NULL, 0);
> +	if (!of_machine_is_compatible("samsung,exynos5440"))
> +		s5p_init_irq(NULL, 0);

How about remove to call s5p_init_irq() here because All exynos SoCs use
GIC instead of VIC?

>   
>   	gic_arch_extn.irq_set_wake = s3c_irq_wake;
>   }
