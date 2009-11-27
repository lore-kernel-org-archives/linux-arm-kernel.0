From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 27 Nov 2009 20:08:55 +0100 (CET)
Subject: [RESENT PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <20091127104454.GA26570@pengutronix.de>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091126105002.GB2393@n2100.arm.linux.org.uk>
	<20091126113158.GC2393@n2100.arm.linux.org.uk>
	<20091127104454.GA26570@pengutronix.de>
Message-ID: <alpine.LFD.2.00.0911272004480.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov 2009, Uwe Kleine-K?nig wrote:
> > which basically leaves us with the implementations interrupt handling
> > function.  If that always calls the event handler with IRQs disabled,
> > then set_next_event will also be called with IRQs disabled.
> Thomas, do you care to shed light on this?

I answered this before and still all CE functions are called with irqs
disabled. The timer interrupt is required to run with irqs disabled
and it was so before we switched to CE and the generic implementation.

> If you don't care I suggest to add the same check as for at91rm2000 for
> the other platforms and see what happens.

And as last time I suggest to add a comment to the ce struct
documentation, only this time I'll do it myself.

Thanks,

	tglx
