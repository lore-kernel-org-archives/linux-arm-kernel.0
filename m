From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 18 Apr 2011 21:32:42 +0200 (CEST)
Subject: genirq: Implement a generic interrupt chip
In-Reply-To: <0D753D10438DA54287A00B027084269764D221CC64@AUSP01VMBX24.collaborationhost.net>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.117340150@linutronix.de>
	<0D753D10438DA54287A00B027084269764D221CC64@AUSP01VMBX24.collaborationhost.net>
Message-ID: <alpine.LFD.2.00.1104182130470.2744@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Apr 2011, H Hartley Sweeten wrote:
> On Saturday, April 16, 2011 2:14 PM, Thomas Gleixner wrote:
> > +void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
> > +			    unsigned int clr, unsigned int set)
> > +{
> > +	struct irq_chip_type *ct = gc->chip_types;
> > +	unsigned int i;
> > +
> > +	/* Init mask cache */
> > +	if (ct->irq_mask == irq_gc_mask_clr_bit ||
> > +	    ct->irq_mask == irq_gc_mask_set_bit)
> 
> struct irq_chip_type does not have a member named 'irq_mask'

Found that already. Needs to be ct->chip_types->irq_mask of course.

Someday I hope that the patch to quilt which forces a refresh of the
queue _BEFORE_ generating mail will surface :)

Thanks,

	tglx
