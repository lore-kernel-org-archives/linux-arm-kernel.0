From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Feb 2011 18:32:04 -0000
Subject: [PATCH 2/5] ARM: omap: update GPIO chained IRQ handler to use EOI
	in parent chip
In-Reply-To: <20110222181805.GM15225@atomide.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-3-git-send-email-will.deacon@arm.com>
	<20110222181805.GM15225@atomide.com>
Message-ID: <001c01cbd2be$ce2b3b30$6a81b190$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> * Will Deacon <will.deacon@arm.com> [110221 07:28]:
> > On OMAP4, gpio_irq_handler can be chained to a physical interrupt using
> > the GIC as the primary IRQ chip. Now that the GIC uses the fasteoi flow
> > model, the chained handler must invoke ->irq_eoi once handling is
> > complete.
> >
> > This patch adds a conditional call to ->irq_eoi in the GPIO IRQ handler
> > for OMAP platforms. For OMAP implementations using other primary
> > interrupt controllers, the ->irq_ack call remains and is also made
> > conditional on the support offered by the controller.
> >
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Colin Cross <ccross@google.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks Tony, I'll add your ack.

Will
