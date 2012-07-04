From: pavel@denx.de (Pavel Machek)
Date: Wed, 4 Jul 2012 13:15:23 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120627162014.1494cdd7@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate>
Message-ID: <20120704111523.GA31490@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +/*
> > + * Set up the clock source and clock events devices
> > + */
> > +
> > +void __init socfpga_timer_init(void __iomem *src_timer_base,
> > +				void __iomem *event_timer_base,
> > +				unsigned int event_timer_irq)
> > +{
> > +	/*
> > +	 * Initialise to a known state (all timers off)
> > +	 */
> > +	writel(0, sp_timer0_va_base + TIMER_CTRL);
> > +	writel(0, sp_timer1_va_base + TIMER_CTRL);
> > +	writel(0, osc_timer0_va_base + TIMER_CTRL);
> > +	writel(0, osc_timer1_va_base + TIMER_CTRL);
> 
> Shouldn't this be done within the timer driver itself?


> > +++ b/arch/arm/mach-socfpga/dw_apb_timer.c
> 
> The clocksource/clockevents driver now go into drivers/clocksource/,
> and the corresponding maintainers should be CC'ed (Thomas Gleixner and
> John Stultz.

Hmm, fortunately drivers/clocksource already has one such
driver. Maybe  arch/arm/mach-picoxcell/time.c can be used as a
template?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
