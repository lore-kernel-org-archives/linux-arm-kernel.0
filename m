From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 14 Jan 2015 14:34:48 +0100
Subject: [PATCH v2 4/5] ARM: at91/dt: add AIC irq1 muxed peripheral id
 definitions
In-Reply-To: <54B66D6B.9050205@atmel.com>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-5-git-send-email-boris.brezillon@free-electrons.com>
 <54B66D6B.9050205@atmel.com>
Message-ID: <20150114143448.09d362b8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Jan 2015 14:21:47 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Le 13/01/2015 19:46, Boris Brezillon a ?crit :
> > These ids will be used to define irqs multiplexed on the first irq line.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  .../dt-bindings/interrupt-controller/atmel-aic.h   | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 include/dt-bindings/interrupt-controller/atmel-aic.h
> > 
> > diff --git a/include/dt-bindings/interrupt-controller/atmel-aic.h b/include/dt-bindings/interrupt-controller/atmel-aic.h
> > new file mode 100644
> > index 0000000..e14a94f
> > --- /dev/null
> > +++ b/include/dt-bindings/interrupt-controller/atmel-aic.h
> > @@ -0,0 +1,22 @@
> > +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H
> > +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H
> 
> Nit.: why ARM_GIC?

Because I copied it from the arm-gic.h header and forgot to rename
those macros :-).
I'll fix that.

> 
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +#define AIC_IRQ1_PMC		0
> > +#define AIC_IRQ1_ST		1
> > +#define AIC_IRQ1_PIT		1
> > +#define AIC_IRQ1_DBGU		2
> > +#define AIC_IRQ1_RTC		3
> > +#define AIC_IRQ1_RTT		4
> > +#define AIC_IRQ1_WATCHDOG	5
> > +#define AIC_IRQ1_MC		6
> > +#define AIC_IRQ1_SDRAMC		6
> > +#define AIC_IRQ1_DDRSDRC	6
> > +#define AIC_IRQ1_RSTC		7
> > +#define AIC_IRQ1_PMERRLOC	8
> > +#define AIC_IRQ1_PMECC		9

Following up the discussion we had privately regarding these
macros (whether we really need them or not), maybe adding a comment
above the irqs property would be enough:

	dumb_irq1_demux: dumb-irq-demux at 1 {
		compatible = "irqchip-dumb-demux";
		interrupt-controller;
		#interrupt-cells = <1>;
		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
		/*
		 * Interrupt lines:
		 * 0: PMC
		 * 1: PIT
		 * 2: DBGU
		 * 3: RTT
		 * 4: WATCHDOG
		 * 5: RSTC
		 */
		irqs = <0x3f>;
	};

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
