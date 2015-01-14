From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 14 Jan 2015 14:21:47 +0100
Subject: [PATCH v2 4/5] ARM: at91/dt: add AIC irq1 muxed peripheral id
 definitions
In-Reply-To: <1421174781-4340-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54B66D6B.9050205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2015 19:46, Boris Brezillon a ?crit :
> These ids will be used to define irqs multiplexed on the first irq line.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../dt-bindings/interrupt-controller/atmel-aic.h   | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 include/dt-bindings/interrupt-controller/atmel-aic.h
> 
> diff --git a/include/dt-bindings/interrupt-controller/atmel-aic.h b/include/dt-bindings/interrupt-controller/atmel-aic.h
> new file mode 100644
> index 0000000..e14a94f
> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/atmel-aic.h
> @@ -0,0 +1,22 @@
> +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H
> +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H

Nit.: why ARM_GIC?

> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#define AIC_IRQ1_PMC		0
> +#define AIC_IRQ1_ST		1
> +#define AIC_IRQ1_PIT		1
> +#define AIC_IRQ1_DBGU		2
> +#define AIC_IRQ1_RTC		3
> +#define AIC_IRQ1_RTT		4
> +#define AIC_IRQ1_WATCHDOG	5
> +#define AIC_IRQ1_MC		6
> +#define AIC_IRQ1_SDRAMC		6
> +#define AIC_IRQ1_DDRSDRC	6
> +#define AIC_IRQ1_RSTC		7
> +#define AIC_IRQ1_PMERRLOC	8
> +#define AIC_IRQ1_PMECC		9




> +
> +#define AIC_IRQ_MASK(x)		(1 << x)
> +
> +#endif
> 


-- 
Nicolas Ferre
