From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 3 Aug 2015 21:20:41 +0530
Subject: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4x12
In-Reply-To: <2347616.SxxJmTVssu@amdc1976>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <4532306.AVvo5hem3c@amdc1976> <55BF4D41.1060903@samsung.com>
 <2347616.SxxJmTVssu@amdc1976>
Message-ID: <20150803155041.GE21529@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-08-15, 15:55, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 81064cd..491914c 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -25,6 +25,8 @@ menuconfig ARCH_EXYNOS
>  	select S5P_DEV_MFC
>  	select SRAM
>  	select MFD_SYSCON
> +	select THERMAL
> +	select EXYNOS_THERMAL

Why do you need to select both of them?

>  	help
>  	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
>  
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 77ac021..1c47aee 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -227,6 +227,8 @@ static void __init exynos_init_irq(void)
>  static const struct of_device_id exynos_cpufreq_matches[] = {
>  	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
> +	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
> +	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
>  	{ /* sentinel */ }
>  };

Otherwise looks fine:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
