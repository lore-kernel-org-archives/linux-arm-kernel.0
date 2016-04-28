From: m.reichl@fivetechno.de (Markus Reichl)
Date: Thu, 28 Apr 2016 16:55:06 +0200
Subject: [PATCH] ARM: exynos_defconfig: Disable big.LITTLE switcher
In-Reply-To: <1493315.8NlXQFsEtt@amdc1976>
References: <1493315.8NlXQFsEtt@amdc1976>
Message-ID: <5722244A.5070608@fivetechno.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

Tested on Odroid XU3 and XU4.

Tested-by: Markus Reichl <m.reichl@fivetechno.de>

Am 28.04.2016 um 16:44 schrieb Bartlomiej Zolnierkiewicz:
> Disable big.LITTLE switcher in order to allow automatic usage of
> cpufreq-dt driver on Exynos542x/Exynos5800 SoCs based boards.
> 
> This change should not cause any problems as arm_big_little[_dt]
> driver (which is using big.LITTLE switcher support to do the "real"
> big.LITTLE switching work) is not used on any Exynos SoC based
> board currently.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index a8cf295..07d4168 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -13,8 +13,6 @@ CONFIG_ARCH_EXYNOS3=y
>  CONFIG_EXYNOS5420_MCPM=y
>  CONFIG_SMP=y
>  CONFIG_BIG_LITTLE=y
> -CONFIG_BL_SWITCHER=y
> -CONFIG_BL_SWITCHER_DUMMY_IF=y
>  CONFIG_NR_CPUS=8
>  CONFIG_PREEMPT=y
>  CONFIG_AEABI=y
> 

Thanks,
--
Markus Reichl
