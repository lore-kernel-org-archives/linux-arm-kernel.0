From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Jun 2014 23:55:52 +0900
Subject: [PATCH v2 04/08] ARM: shmobile: Move most of irqs.h, keep some
 for pinctl
In-Reply-To: <20140617074729.30008.55742.sendpatchset@w520>
References: <20140617074658.30008.53021.sendpatchset@w520>
 <20140617074729.30008.55742.sendpatchset@w520>
Message-ID: <20140618145549.GA16873@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 04:47:29PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Move most of irqs.h so it can be used as #include "irqs.h"
> instead of the old style #include <mach/irqs.h>.
> 
> Legacy code in drivers/pinctrl needs more work to get rid
> of the "mach" portion of the include path, so some part
> is left in the original location.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
>  Changes since V1:
>  - rebased to v3.16-rc1

[snip]

> --- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
> +++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2014-06-17 16:03:57.000000000 +0900
> @@ -1,24 +1,11 @@
>  #ifndef __ASM_MACH_IRQS_H
>  #define __ASM_MACH_IRQS_H
>  
> -#include <linux/sh_intc.h>
> -
> -/* GIC */
> -#define gic_spi(nr)		((nr) + 32)
> -#define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */
> -
> -/* INTCS */
> -#define INTCS_VECT_BASE		0x3400
> -#define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
> -#define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
> +/* Stuck here until drivers/pinctl/sh-pfc gets rid of legacy code */
>  
>  /* External IRQ pins */
>  #define IRQPIN_BASE		2000
>  #define irq_pin(nr)		((nr) + IRQPIN_BASE)
>  
> -/* GPIO IRQ */
> -#define _GPIO_IRQ_BASE		2500
> -#define GPIO_IRQ_BASE(x)	(_GPIO_IRQ_BASE + (32 * x))
> -#define GPIO_IRQ(x, y)		(_GPIO_IRQ_BASE + (32 * x) + y)
> -
>  #endif /* __ASM_MACH_IRQS_H */
> +

I removed the trailing blank line this patch adds here.

[snip]
