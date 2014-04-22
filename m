From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 22 Apr 2014 12:42:04 +0200
Subject: [PATCH 1/4] cpuidle: config: Add SOC_EXYNOS5420 entry to select
 cpuidle-big-little driver
In-Reply-To: <1398080958-21677-2-git-send-email-chander.kashyap@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
 <1398080958-21677-2-git-send-email-chander.kashyap@linaro.org>
Message-ID: <5356477C.1070403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2014 01:49 PM, Chander Kashyap wrote:
> Exynos5420 is a big-little SoC from Samsung. It has 4 A15 and 4 A7 cores.
> In order to use generic cpuidle-big-little driver, this patch adds Exynos5420
> specific check to initialize generic cpuidle driver.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> ---
>   drivers/cpuidle/Kconfig.arm |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 97ccc31..5244d87 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -4,7 +4,7 @@
>
>   config ARM_BIG_LITTLE_CPUIDLE
>   	bool "Support for ARM big.LITTLE processors"
> -	depends on ARCH_VEXPRESS_TC2_PM
> +	depends on ARCH_VEXPRESS_TC2_PM || SOC_EXYNOS5420

For the sake of consistency, I would prefer:

depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS

and let the current code (and future platform driver) to handle the 
loading of the driver.

>   	select ARM_CPU_SUSPEND
>   	select CPU_IDLE_MULTIPLE_DRIVERS
>   	help
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
