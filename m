From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 22 Apr 2015 10:13:30 +0200
Subject: [PATCH 5/8] ARM: Exynos: use generic cpufreq driver for Exynos5420
In-Reply-To: <1429622278-12216-6-git-send-email-b.zolnierkie@samsung.com>
References: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
 <1429622278-12216-6-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150422101330.5dbec7bc@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The new CPU clock type allows the use of generic arm_big_little_dt
> cpufreq driver for Exynos5420.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patch
> - disable cpufreq if big.LITTLE switcher support is enabled
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c
> b/arch/arm/mach-exynos/exynos.c index 4b03a32..11ac7fb 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -207,6 +207,13 @@ struct cpufreq_dt_platform_data cpufreq_dt_pd = {
>  static const struct of_device_id exynos_cpufreq_matches[] = {
>  	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
> +/*
> + * FIXME: When big.LITTLE switcher is enabled system lockups during
> + * ondemand governor stress testing (observed on ODROID-XU3 board).
> + */
> +#ifndef CONFIG_BL_SWITCHER
> +	{ .compatible = "samsung,exynos5420", .data =
> "arm-bL-cpufreq-dt" }, +#endif
>  	{ /* sentinel */ }
>  };
>  

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
