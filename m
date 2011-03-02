From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 2 Mar 2011 10:27:34 +0100 (CET)
Subject: [PATCH v7 1/1] PRUSS UIO driver support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BF36776@dbde02.ent.ti.com>
References: <1299014895-2022-1-git-send-email-pratheesh@ti.com>
	<1299014895-2022-2-git-send-email-pratheesh@ti.com>
	<alpine.LFD.2.00.1103012238360.2701@localhost6.localdomain6>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF36776@dbde02.ent.ti.com>
Message-ID: <alpine.LFD.2.00.1103021026240.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Mar 2011, TK, Pratheesh Gangadhar wrote:
> > From: Thomas Gleixner [mailto:tglx at linutronix.de]
> > > +	/* Disable interrupt */
> > > +	iowrite32((val & ~intr_mask), intren_reg);
> 
> I checked more on this and actually INTC h/w has Host Interrupt
> Enable Indexed Set Register (HIEISR) and Host Interrupt Enable Indexed
> Clear Register(HIEICR) which I can use to enable/disable interrupts
> without doing RMW. I will use these registers and then we don't need
> all the spinlock and irqcontrol stuff. So I need to do
> 
> iowrite32((intr_bit, HIEICR);// This disable the interrupt bit
> in intern_reg.
> 
> Userspace can use HIEISR to re-enable the interrupt.

Great, that makes it way simpler!
 
> > It's not the purpose of a review to tell you what you need to change
> > mechanically. Reviewers hint to a correct solution and you are
> > supposed to lookup what that solution means and act accordingly. If
> > you do not understand the hint or its implications please ask _before_
> > sending a new patch set.
> 
> Seriously, I went to "fix the comments" mode. Sorry about that. Anyway
> I learnt more about things by making mistakes i.e. the positive side.
> Thanks a lot for helping us improve on this. 

Welcome!


	tglx
