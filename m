From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 20 Jan 2014 08:48:14 +0100
Subject: [PATCH v2 6/7] ARM: Exynos: switch to using generic cpufreq-cpu0
 driver
In-Reply-To: <1390047057-2239-7-git-send-email-thomas.ab@samsung.com>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <1390047057-2239-7-git-send-email-thomas.ab@samsung.com>
Message-ID: <20140120084814.220a8efa@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Remove the platform device instantiation for Exynos specific cpufreq
> driver and add the platform device for cpufreq-cpu0 driver.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/mach-exynos/common.c          |    5 -----
>  arch/arm/mach-exynos/common.h          |    1 -
>  arch/arm/mach-exynos/mach-exynos4-dt.c |    2 +-
>  arch/arm/mach-exynos/mach-exynos5-dt.c |    2 +-
>  4 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c
> b/arch/arm/mach-exynos/common.c index f18be40..72ae5d3 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -303,11 +303,6 @@ void __init exynos_cpuidle_init(void)
>  	platform_device_register(&exynos_cpuidle);
>  }
>  
> -void __init exynos_cpufreq_init(void)
> -{
> -	platform_device_register_simple("exynos-cpufreq", -1, NULL,
> 0); -}
> -
>  void __init exynos_init_late(void)
>  {
>  	if (of_machine_is_compatible("samsung,exynos5440"))
> diff --git a/arch/arm/mach-exynos/common.h
> b/arch/arm/mach-exynos/common.h index f76967b..0c31b34 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -22,7 +22,6 @@ void exynos_init_io(void);
>  void exynos4_restart(enum reboot_mode mode, const char *cmd);
>  void exynos5_restart(enum reboot_mode mode, const char *cmd);
>  void exynos_cpuidle_init(void);
> -void exynos_cpufreq_init(void);
>  void exynos_init_late(void);
>  
>  void exynos_firmware_init(void);
> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c
> b/arch/arm/mach-exynos/mach-exynos4-dt.c index d3e54b7..9a25320 100644
> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> @@ -22,8 +22,8 @@
>  static void __init exynos4_dt_machine_init(void)
>  {
>  	exynos_cpuidle_init();
> -	exynos_cpufreq_init();
>  
> +	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL,
> NULL); }
>  
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c
> b/arch/arm/mach-exynos/mach-exynos5-dt.c index 37ea261..9dc3710 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -44,8 +44,8 @@ static void __init exynos5_dt_machine_init(void)
>  	}
>  
>  	exynos_cpuidle_init();
> -	exynos_cpufreq_init();
>  
> +	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL,
> NULL); }
>  

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
