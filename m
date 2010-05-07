From: srinidhi.kasagar@stericsson.com (srinidhi)
Date: Fri, 7 May 2010 10:14:46 +0530
Subject: [PATCH 1/2] ARM TWD: move TWD registers to common header
In-Reply-To: <1273207265-21888-1-git-send-email-srinidhi.kasagar@stericsson.com>
References: <1273207265-21888-1-git-send-email-srinidhi.kasagar@stericsson.com>
Message-ID: <1273207486.10589.1.camel@bnru03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copying Wim Van Sebroeck

Srinidhi

On Fri, 2010-05-07 at 06:41 +0200, Srinidhi KASAGAR wrote:
> This moves the TWD register set of MPcore to a common
> existing file so that watchdog driver can access it
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/include/asm/smp_twd.h |   17 +++++++++++++++++
>  arch/arm/kernel/smp_twd.c      |   17 -----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
> index 7be0978..634f357 100644
> --- a/arch/arm/include/asm/smp_twd.h
> +++ b/arch/arm/include/asm/smp_twd.h
> @@ -1,6 +1,23 @@
>  #ifndef __ASMARM_SMP_TWD_H
>  #define __ASMARM_SMP_TWD_H
>  
> +#define TWD_TIMER_LOAD			0x00
> +#define TWD_TIMER_COUNTER		0x04
> +#define TWD_TIMER_CONTROL		0x08
> +#define TWD_TIMER_INTSTAT		0x0C
> +
> +#define TWD_WDOG_LOAD			0x20
> +#define TWD_WDOG_COUNTER		0x24
> +#define TWD_WDOG_CONTROL		0x28
> +#define TWD_WDOG_INTSTAT		0x2C
> +#define TWD_WDOG_RESETSTAT		0x30
> +#define TWD_WDOG_DISABLE		0x34
> +
> +#define TWD_TIMER_CONTROL_ENABLE	(1 << 0)
> +#define TWD_TIMER_CONTROL_ONESHOT	(0 << 1)
> +#define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
> +#define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
> +
>  struct clock_event_device;
>  
>  extern void __iomem *twd_base;
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index ea02a7b..7c5f0c0 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -21,23 +21,6 @@
>  #include <asm/smp_twd.h>
>  #include <asm/hardware/gic.h>
>  
> -#define TWD_TIMER_LOAD 			0x00
> -#define TWD_TIMER_COUNTER		0x04
> -#define TWD_TIMER_CONTROL		0x08
> -#define TWD_TIMER_INTSTAT		0x0C
> -
> -#define TWD_WDOG_LOAD			0x20
> -#define TWD_WDOG_COUNTER		0x24
> -#define TWD_WDOG_CONTROL		0x28
> -#define TWD_WDOG_INTSTAT		0x2C
> -#define TWD_WDOG_RESETSTAT		0x30
> -#define TWD_WDOG_DISABLE		0x34
> -
> -#define TWD_TIMER_CONTROL_ENABLE	(1 << 0)
> -#define TWD_TIMER_CONTROL_ONESHOT	(0 << 1)
> -#define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
> -#define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
> -
>  /* set up by the platform code */
>  void __iomem *twd_base;
>  
