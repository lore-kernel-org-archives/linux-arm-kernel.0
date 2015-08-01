From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 1 Aug 2015 16:47:21 +0530
Subject: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4x12
In-Reply-To: <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150801111721.GI899@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 659879a..bf6d596 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -191,6 +191,7 @@ config CPUFREQ_DT
>  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
>  	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
> +	select EXYNOS_THERMAL if ARCH_EXYNOS
>  	help
>  	  This adds a generic DT based cpufreq driver for frequency management.
>  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)

No, we shouldn't pollute generic Kconfig options with platform specific stuff.
Why don't you enable thermal in your .config?

-- 
viresh
