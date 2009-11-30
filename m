From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 30 Nov 2009 18:48:43 +0100 (CET)
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130143956.GA8227@n2100.arm.linux.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<20091130143703.GA7028@n2100.arm.linux.org.uk>
	<20091130143956.GA8227@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911301847221.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2009, Russell King - ARM Linux wrote:

> On Mon, Nov 30, 2009 at 02:37:03PM +0000, Russell King - ARM Linux wrote:
> > Now, at the risk of covering old ground, how about we have two separate
> > irqaction lists, one for handlers to be called with irqs disabled and
> > one for handlers with irqs enabled.  We run the irqs-disabled list
> > first, naturally with irqs disabled.  If, at the end of that run (or
> > maybe after each handler), IRQs have ended being enabled, print some
> > diagnostics.  (We're going to need something like this to ensure that
> > drivers interrupt handlers don't enable IRQs themselves.)  Then enable
> > IRQs and run the irqs-enabled chain.
> 
> Oh, and the other interesting thing to do may be to have a way of
> measuring how much time irq handlers run for, so that handlers taking
> an excessive time (more than 0.5ms or so - thinking about the 1000Hz
> timer rate found on some arches) can be targetted.

.33 will have trace points for this, so the infrastructure is there or
do you think about something permanent which does not depend on the
tracer ?

Thanks,

	tglx
