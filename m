From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jun 2013 21:59:15 +0200
Subject: [PATCH v2 29/38] thermal: exynos: Support both Exynos4x12 SoCs
In-Reply-To: <1371486863-12398-30-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-30-git-send-email-t.figa@samsung.com>
Message-ID: <201306172159.15352.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 June 2013, Tomasz Figa wrote:
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index 788b1dd..4cbe3ee 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -817,7 +817,8 @@ static struct exynos_tmu_platform_data const exynos4210_default_tmu_data = {
>  #define EXYNOS4210_TMU_DRV_DATA (NULL)
>  #endif
>  
> -#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412)
> +#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412) || \
> +       defined(CONFIG_SOC_EXYNOS4212)
>  static struct exynos_tmu_platform_data const exynos_default_tmu_data = {
>         .threshold_falling = 10,
>         .trigger_levels[0] = 85,

The patch is correct, but generally speaking I think we should get away from
having the drivers get configured per SoC on such a fine-grained level.
Better make this driver (and others) always work on all exynos variants.

	Arnd
