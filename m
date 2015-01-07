From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Jan 2015 10:04:30 +0100
Subject: [PATCH] ARM: exynos_defconfig: Enable CONFIG_LOCKUP_DETECTOR
In-Reply-To: <1420566151-7136-1-git-send-email-moon.linux@yahoo.com>
References: <1420566151-7136-1-git-send-email-moon.linux@yahoo.com>
Message-ID: <1420621470.3893.6.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2015-01-06 at 23:12 +0530, Anand Moon wrote:
> ARM Enable CONFIG_LOCKUP_DETECTOR to validaion of kernel locks
s/validaion/validation/

This config item helps getting some useful information when lockup
happens. If you want to validate locks then probably you want
PROVE_LOCKING... but its overhead is larger.

Anyway the overhead of LOCKUP_DETECTOR is small and multi_v7_defconfig
has it enabled so I guess exynos may do it as well.

Could you only fix up the commit msg?


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof

> 
> Tested on Exynos5422 ODROID XU3 board.
> 
> Signed-off-by: Anand Moon <moon.linux@yahoo.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 5ef14de..ecd9987 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -178,6 +178,7 @@ CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_KERNEL=y
> +CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_DETECT_HUNG_TASK=y
>  CONFIG_DEBUG_RT_MUTEXES=y
>  CONFIG_DEBUG_SPINLOCK=y
