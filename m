From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 15:21:46 +0900
Subject: [PATCH 1/7] ARM: S5PV210: add support for software reset
In-Reply-To: <1274079195-18105-2-git-send-email-m.szyprowski@samsung.com>
References: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
	<1274079195-18105-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <010101caf7e4$bd6ef490$384cddb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Add missing call for software reset (system reboot).

Yes, missed.

But Samsung SoC hardware engineer recommends to use the reset of watchdog
instead of software reset by restriction of Hardware environment.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/include/mach/regs-clock.h |    2 ++
>  arch/arm/mach-s5pv210/include/mach/system.h     |    7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
b/arch/arm/mach-
> s5pv210/include/mach/regs-clock.h
> index e56e0e4..40dd24f 100644
> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> @@ -91,6 +91,8 @@
>  #define S5P_CLKDIV0_PCLK66_MASK		(0x7 <<
> S5P_CLKDIV0_PCLK66_SHIFT)
> 
>  /* Registers related to power management */
> +#define S5P_SWRESET		S5P_CLKREG(0x2000)
> +
>  #define S5P_PWR_CFG		S5P_CLKREG(0xC000)
>  #define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0xC004)
>  #define S5P_WAKEUP_MASK 	S5P_CLKREG(0xC008)
> diff --git a/arch/arm/mach-s5pv210/include/mach/system.h b/arch/arm/mach-
> s5pv210/include/mach/system.h
> index 1ca04d5..ba39203 100644
> --- a/arch/arm/mach-s5pv210/include/mach/system.h
> +++ b/arch/arm/mach-s5pv210/include/mach/system.h
> @@ -13,6 +13,10 @@
>  #ifndef __ASM_ARCH_SYSTEM_H
>  #define __ASM_ARCH_SYSTEM_H __FILE__
> 
> +#include <linux/io.h>
> +#include <mach/map.h>
> +#include <mach/regs-clock.h>
> +
>  static void arch_idle(void)
>  {
>  	/* nothing here yet */
> @@ -20,7 +24,8 @@ static void arch_idle(void)
> 
>  static void arch_reset(char mode, const char *cmd)
>  {
> -	/* nothing here yet */
> +	__raw_writel(0x1, S5P_SWRESET);
> +	return;
>  }
> 
>  #endif /* __ASM_ARCH_SYSTEM_H */
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
