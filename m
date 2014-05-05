From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Mon, 05 May 2014 10:59:41 +0200
Subject: [Patch v3 2/5] cpuidle: config: Add ARCH_EXYNOS entry to select
 cpuidle-big-little driver
In-Reply-To: <1399278444-8312-3-git-send-email-chander.kashyap@linaro.org>
References: <1398245154-18771-1-git-send-email-chander.kashyap@linaro.org>
 <1399278444-8312-1-git-send-email-chander.kashyap@linaro.org>
 <1399278444-8312-3-git-send-email-chander.kashyap@linaro.org>
Message-ID: <536752FD.3040704@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 05.05.2014 10:27, schrieb Chander Kashyap:
> Exynos5420 is a big-little SoC from Samsung. It has 4 A15 and 4 A7 cores.
> In order to use generic cpuidle-big-little driver, this patch adds Exynos5420
> specific check to initialize generic cpuidle driver.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> ---
> Changes in v3: None
> Changes in v2:
> 	1. Changed config macro from SOC_EXYNOS5420 to SOC_EXYNOS5420

This is probably a copy&pasto? Anyway, the commit message needs an
update since no Exynos5420 specific check is done below afaics. That
went into 3/5.

Cheers,
Andreas

>  drivers/cpuidle/Kconfig.arm |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 97ccc31..d9596e7 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -4,7 +4,7 @@
>  
>  config ARM_BIG_LITTLE_CPUIDLE
>  	bool "Support for ARM big.LITTLE processors"
> -	depends on ARCH_VEXPRESS_TC2_PM
> +	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
>  	select ARM_CPU_SUSPEND
>  	select CPU_IDLE_MULTIPLE_DRIVERS
>  	help
> 


-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
