From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 28 Apr 2016 23:13:40 +0530
Subject: [PATCH] ARM: exynos_defconfig: Disable big.LITTLE switcher
In-Reply-To: <1493315.8NlXQFsEtt@amdc1976>
References: <1493315.8NlXQFsEtt@amdc1976>
Message-ID: <CANAwSgQboz5g2Zh0vCfNBZ_K+UjHbSUcdeAMNeJn+T3a14OUSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

On 28 April 2016 at 20:14, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
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
> --
> 1.9.1
>

Tested On Odroid XU4.

Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand Moon

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
