From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 27 Nov 2009 23:20:11 +0100 (CET)
Subject: [RESENT PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <20091127215930.GE28193@n2100.arm.linux.org.uk>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091126105002.GB2393@n2100.arm.linux.org.uk>
	<20091126113158.GC2393@n2100.arm.linux.org.uk>
	<20091127104454.GA26570@pengutronix.de>
	<20091127195857.GB28193@n2100.arm.linux.org.uk>
	<20091127203823.GA28789@pengutronix.de>
	<20091127204414.GD28193@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911272203400.24119@localhost.localdomain>
	<20091127215930.GE28193@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911272318260.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov 2009, Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2009 at 10:31:15PM +0100, Thomas Gleixner wrote:
> > On Fri, 27 Nov 2009, Russell King - ARM Linux wrote:
> > > On Fri, Nov 27, 2009 at 09:38:23PM +0100, Uwe Kleine-K?nig wrote:
> > > > OK, so this should make it save for mach-nomadik/timer.c,
> > > > mach-pxa/time.c and mach-sa1100/time.c.
> > > > 
> > > > Only mach-at91/at91rm9200_time.c and mach-at91/at91sam926x_time.c
> > > > request with IRQF_SHARED | IRQF_DISABLED.
> > > > So for there the right solution is to let the local_irq_save in place
> > > > and add a comment that it is needed as the timer irq is shared.
> > > > This hopefully stopps people copying it unnecessarily.
> > > 
> > > Given that the gentime code spits out warnings if its called with IRQs
> > > enabled, I don't think keeping the local_irq_save() in place is worth
> > > it - especially given Thomas' response.
> > > 
> > > We've seen such warnings on AT91 (though I don't think we got positively
> > > to the bottom of it with the reporter.)  If you _do_ want to ensure that
> > 
> > Any pointer ?
> 
> http://lists.arm.linux.org.uk/lurker/thread/20091030.165300.55a15962.en.html

That thread ends unfortunately at the point where it started to be
interesting.

I have AT91 platforms myself and we have not seen any problem at
all.

Thanks,

	tglx
