From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 14:21:34 +0200
Subject: [PATCH V3 12/17] ARM: exynos: cpuidle: Move S5P_CHECK_AFTR in a
 header
In-Reply-To: <1396959579-18268-13-git-send-email-daniel.lezcano@linaro.org>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
 <1396959579-18268-13-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <53453B4E.8000203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 08.04.2014 14:19, Daniel Lezcano wrote:
> Move the S5P_CHECK_AFTR definition to the header it belongs to.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   arch/arm/mach-exynos/cpuidle.c  |    2 --
>   arch/arm/mach-exynos/regs-pmu.h |    1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index 81d7197..cd27dbf 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -37,8 +37,6 @@
>   			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
>   			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
>
> -#define S5P_CHECK_AFTR		0xFCBA0D10
> -
>   #define EXYNOS5_PWR_CTRL1			(S5P_VA_CMU + 0x01020)
>   #define EXYNOS5_PWR_CTRL2			(S5P_VA_CMU + 0x01024)
>
> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
> index 4f6a256..09c43c3 100644
> --- a/arch/arm/mach-exynos/regs-pmu.h
> +++ b/arch/arm/mach-exynos/regs-pmu.h
> @@ -120,6 +120,7 @@
>   #define S5P_INT_LOCAL_PWR_EN			0x7
>
>   #define S5P_CHECK_SLEEP				0x00000BAD
> +#define S5P_CHECK_AFTR				0xFCBA0D10

This is not really a PMU-specific value. It is not a part of the 
hardware programming interface, but rather a part of the 
kernel-bootloader ABI used to handle wake-up from low power states. Same 
applies to S5P_CHECK_SLEEP.

I believe the proper place for such definitions would be the source file 
using it, which after patch 14/17 would be pm.c.

Best regards,
Tomasz
