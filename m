From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Sep 2015 14:02:48 +0900
Subject: [PATCH] ARM: exynos_defconfig: Make S3C2410_WATCHDOG as loadable
 module
In-Reply-To: <1441253429-3264-1-git-send-email-linux.amoon@gmail.com>
References: <1441253429-3264-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <55E7D478.2020200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.09.2015 13:10, Anand Moon wrote:
> S3C2410_WATCHDOG watchdog drivers should not be loaded automatically,
> but only if a watchdog daemon is installed.

First of all: why?

Secondly: even as a module driver could be loaded automatically to match
enabled device (it has MODULE_DEVICE_TABLE). In the same time loading it
does not hurt - watchdog should be inactive:

s3c2410-wdt 10060000.watchdog: watchdog inactive, reset disabled, irq
disabled

Best regards,
Krzysztof

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/configs/exynos_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index aaf7aa4..b5d382e 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -101,7 +101,7 @@ CONFIG_CPU_THERMAL=y
>  CONFIG_THERMAL_EMULATION=y
>  CONFIG_EXYNOS_THERMAL=y
>  CONFIG_WATCHDOG=y
> -CONFIG_S3C2410_WATCHDOG=y
> +CONFIG_S3C2410_WATCHDOG=m
>  CONFIG_MFD_CROS_EC=y
>  CONFIG_MFD_CROS_EC_I2C=y
>  CONFIG_MFD_CROS_EC_SPI=y
> 
