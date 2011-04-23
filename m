From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 23 Apr 2011 23:40:42 +0200 (CEST)
Subject: [patch 01/16] time: Provide clocksource based sched_clock()
In-Reply-To: <4DB3458D.6000806@codeaurora.org>
References: <20110423205036.795894921@linutronix.de>
	<20110423205131.574884925@linutronix.de>
	<4DB3458D.6000806@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1104232339370.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

B1;2601;0cOn Sat, 23 Apr 2011, Stephen Boyd wrote:

> On 4/23/2011 1:54 PM, Thomas Gleixner wrote:
> > Index: linux-2.6-tip/kernel/time/Kconfig
> > ===================================================================
> > --- linux-2.6-tip.orig/kernel/time/Kconfig
> > +++ linux-2.6-tip/kernel/time/Kconfig
> > @@ -27,3 +27,7 @@ config GENERIC_CLOCKEVENTS_BUILD
> >  	default y
> >  	depends on GENERIC_CLOCKEVENTS || GENERIC_CLOCKEVENTS_MIGR
> > 
> > +# Selectable by architectures which want to reuse the clocksource as
> > +# sched_clock
> > +config HAVE_CLKSRC_SCHED_CLOCK
> > +       bool
> 
> >From what I can tell this isn't used so I'm guessing we can drop it?

Oops. Yes. Leftover from first version. I decided not to clutter the
tree with another "select HAVE_...."

Thanks,

	tglx
