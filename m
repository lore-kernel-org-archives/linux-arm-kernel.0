From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 9 Jan 2018 13:33:36 +0100
Subject: [PATCH 3/9] soc: samsung: pmu: Add the PMU data of exynos5433 to
 support low-power state
In-Reply-To: <1515484746-10656-4-git-send-email-cw00.choi@samsung.com>
References: <CGME20180109075905epcas1p321b8898a0d45287d63364e1aa768fdab@epcas1p3.samsung.com>
 <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <1515484746-10656-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAJKOXPdijTxJAR0AxnMtxKm3T_y7vSv=k22jKMB87xsb6S-wPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 8:59 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch adds the PMU (Power Management Unit) data of exynos5433 SoC
> in order to support the various power modes. Each power mode has
> the different value for reducing the power-consumption.
>
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h               |   2 -
>  drivers/soc/samsung/Makefile                |   3 +-
>  drivers/soc/samsung/exynos-pmu.c            |   1 +
>  drivers/soc/samsung/exynos-pmu.h            |   2 +
>  drivers/soc/samsung/exynos5433-pmu.c        | 286 ++++++++++++++++++++++++++++
>  include/linux/soc/samsung/exynos-regs-pmu.h | 148 ++++++++++++++
>  6 files changed, 439 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/soc/samsung/exynos5433-pmu.c
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 098f84a149a3..afbc143a3d5d 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -125,8 +125,6 @@ enum {
>  void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
>  void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
>
> -extern u32 exynos_get_eint_wake_mask(void);
> -
>  #ifdef CONFIG_PM_SLEEP
>  extern void __init exynos_pm_init(void);
>  #else
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 29f294baac6e..d2e637339a45 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -2,5 +2,6 @@
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
>
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
> -                                       exynos5250-pmu.o exynos5420-pmu.o
> +                                       exynos5250-pmu.o exynos5420-pmu.o \
> +                                       exynos5433-pmu.o

... ah, I forgot. No. Exynos5433 is not ARMv7.

 Best regards,
Krzysztof
