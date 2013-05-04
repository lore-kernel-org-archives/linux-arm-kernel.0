From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 04 May 2013 04:37:24 +0200
Subject: [RFC patch 8/8] irqchip: sun4i: Convert to generic irq chip
In-Reply-To: <20130503214629.880345092@linutronix.de>
References: <alpine.LFD.2.02.1305031514230.2886@ionos>
 <20130503212258.385818955@linutronix.de>
 <20130503214629.880345092@linutronix.de>
Message-ID: <51847464.8040802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2013 11:50 PM, Thomas Gleixner wrote:
 > Proof of concept patch to demonstrate the new irqdomain support for
 > the generic irq chip. Untested !!
 >
 > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
 > ---
...
 > +		gc->reg_base = sun4i_irq_base;
 > +		gc->chip_types[0].regs.mask = SUN4I_IRQ_ENABLE_REG(i);
 > +		gc->chip_types[0].regs.ack = SUN4I_IRQ_PENDING_REG(i);
 > +		gc->chip_types[0].chip.mask = irq_gc_mask_clr_bit;
 > +		gc->chip_types[0].chip.ack = irq_gc_ack_set_bit;
 > +		gc->chip_types[0].chip.unmask = irq_gc_mask_set_bit;

To help Maxime debug, the three callbacks must be prepended by irq_,
i.e. chip.irq_mask, ...

Sebastian
