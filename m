From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Mar 2013 20:27:02 +0100
Subject: [PATCH] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <20130312160101.GW4977@n2100.arm.linux.org.uk>
References: <1363103673-24720-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130312160101.GW4977@n2100.arm.linux.org.uk>
Message-ID: <20130312192702.GQ15375@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 04:01:01PM +0000, Russell King - ARM Linux wrote:
> On Tue, Mar 12, 2013 at 04:54:33PM +0100, Uwe Kleine-K?nig wrote:
> > +#include <asm/irq.h>
> > +#include <asm/io.h>
> 
> linux/io.h
> 
> > +	unsigned int irqs, i, irq_base;
> > +
> > +	irq_base = irq_alloc_descs(-1, 16, irqs - 16, numa_node_id());
> > +	if (IS_ERR_VALUE(irq_base)) {
> 
> Erm... irq_alloc_descs() returns a negative number on error.
> 
> 	if ((int)irq_base < 0)
> 
> or make irq_base an int, and use:
> 
> 	if (irq_base < 0)
Just for me: So the check using IS_ERR_VALUE is as wrong as the other
occurences in arch/arm that you just kicked out or is it just ugly?

I thought about it and went the "make irq_base int" route (and even
fixed the asm includes) even before I sent my patch. Just failed to pass
the right hash to format-patch after rebasing :-|

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
