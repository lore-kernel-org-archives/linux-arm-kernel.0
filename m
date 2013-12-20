From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Dec 2013 06:34:54 +0900
Subject: [PATCH] ARM: EXYNOS: Consolidate selection of PM_GENERIC_DOMAINS
 for Exynos4
In-Reply-To: <1387574696-26366-1-git-send-email-s.nawrocki@samsung.com>
References: <1387574696-26366-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <52B4B7FE.8010003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/13 06:24, Sylwester Nawrocki wrote:
> Instead of repeating "select PM_GENERIC_DOMAINS" for all Exynos4
> variants add relevant entry in the Kconfig section common to the
> SoC series.
>
> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
> ---
>   arch/arm/mach-exynos/Kconfig |    4 +---
>   1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 1414bc6..35c335d 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -24,6 +24,7 @@ config ARCH_EXYNOS4
>   	select HAVE_SMP
>   	select MIGHT_HAVE_CACHE_L2X0
>   	select PINCTRL
> +	select PM_GENERIC_DOMAINS if PM
>   	select S5P_DEV_MFC
>   	help
>   	  Samsung EXYNOS4 SoCs based systems
> @@ -48,7 +49,6 @@ config CPU_EXYNOS4210
>   	select ARCH_HAS_BANDGAP
>   	select ARM_CPU_SUSPEND if PM
>   	select PINCTRL_EXYNOS
> -	select PM_GENERIC_DOMAINS if PM
>   	select S5P_PM if PM
>   	select S5P_SLEEP if PM
>   	select SAMSUNG_DMADEV
> @@ -61,7 +61,6 @@ config SOC_EXYNOS4212
>   	depends on ARCH_EXYNOS4
>   	select ARCH_HAS_BANDGAP
>   	select PINCTRL_EXYNOS
> -	select PM_GENERIC_DOMAINS if PM
>   	select S5P_PM if PM
>   	select S5P_SLEEP if PM
>   	select SAMSUNG_DMADEV
> @@ -74,7 +73,6 @@ config SOC_EXYNOS4412
>   	depends on ARCH_EXYNOS4
>   	select ARCH_HAS_BANDGAP
>   	select PINCTRL_EXYNOS
> -	select PM_GENERIC_DOMAINS if PM
>   	select SAMSUNG_DMADEV
>   	help
>   	  Enable EXYNOS4412 SoC support

Applied, thanks.
- Kukjin
