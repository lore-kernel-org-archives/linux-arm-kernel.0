From: Pawel.Moll@arm.com (Pawel Moll)
Date: Tue, 23 Nov 2010 19:41:02 +0000
Subject: [PATCH] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
In-Reply-To: <20101123100546.GL4693@pengutronix.de>
References: <1290431040-15417-1-git-send-email-pawel.moll@arm.com>
	<1290431295-16052-1-git-send-email-pawel.moll@arm.com>
	<20101123100546.GL4693@pengutronix.de>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA45911B98458@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +   WARN_ON(max_irq > NR_IRQS);
> > +   max_irq = min(max_irq, NR_IRQS);
> Maybe make this
>       if (WARN_ON(max_irq > NR_IRQS))
>               max_irq = NR_IRQS;

Fine by me :-)

> First (judging from the name) max_irq is used as irq number, while
> NR_IRQS must not be used as such (i.e. NR_IRQS - 1 is the last valid
> number).  But maybe the variable is just (IMHO) bad.

Yeah, the "max_irq" is actually "gic_irqs" rather than anything else.

> >      * Setup the Linux IRQ subsystem.
> >      */
> >     for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq;
> i++) {
> And further shouldn't gic_data[gic_nr].irq_offset be taken into account
> when limiting max_irq?

That's what happens if you try to make as little changes as possible ;-) I should have Done It Right (TM) immediately. A patch follows.

Cheers!

Pawe?

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
