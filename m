From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Feb 2011 19:44:32 +0530
Subject: [PATCH 2/5] ARM: omap: update GPIO chained IRQ handler to use EOI
	in parent chip
In-Reply-To: <e25ffece0a5b549a68c28ca29abb847a@mail.gmail.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-3-git-send-email-will.deacon@arm.com>
	<e25ffece0a5b549a68c28ca29abb847a@mail.gmail.com>
Message-ID: <bb6bff8b082a50e6b739b22bad6ab6ec@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Tuesday, February 22, 2011 12:45 AM
> To: Will Deacon; linux-arm-kernel at lists.infradead.org
> Cc: linux at arm.linux.org.uk; adharmap at codeaurora.org; rabin at rab.in;
> tglx at linutronix.de; catalin.marinas at arm.com; ccross at google.com;
> kyungmin.park at samsung.com
> Subject: RE: [PATCH 2/5] ARM: omap: update GPIO chained IRQ handler
> to use EOI in parent chip
>
> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon at arm.com]
> > Sent: Monday, February 21, 2011 8:58 PM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: linux at arm.linux.org.uk; adharmap at codeaurora.org; rabin at rab.in;
> > tglx at linutronix.de; catalin.marinas at arm.com;
> > santosh.shilimkar at ti.com; ccross at google.com;
> > kyungmin.park at samsung.com; Will Deacon
> > Subject: [PATCH 2/5] ARM: omap: update GPIO chained IRQ handler to
> > use EOI in parent chip
> >
> > On OMAP4, gpio_irq_handler can be chained to a physical interrupt
> > using
> > the GIC as the primary IRQ chip. Now that the GIC uses the fasteoi
> > flow
> > model, the chained handler must invoke ->irq_eoi once handling is
> > complete.
> >
> > This patch adds a conditional call to ->irq_eoi in the GPIO IRQ
> > handler
> > for OMAP platforms. For OMAP implementations using other primary
> > interrupt controllers, the ->irq_ack call remains and is also made
> > conditional on the support offered by the controller.
> >
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Colin Cross <ccross@google.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> Thanks Will for changes. They look fine.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> I will test your series tomorrow on OMAP with some
> GPIO interrupts.
>
Tested your series on OMAP4 SDP, where GPIO is used for
ethernet interrupts. They seems to work as expected.
For omap changes,
	Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards,
Santosh
