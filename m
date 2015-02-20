From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 20 Feb 2015 22:48:28 +0100
Subject: [PATCH v2 04/18] clocksource: Add ARM System timer driver
In-Reply-To: <20150220195437.GT19388@pengutronix.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220195437.GT19388@pengutronix.de>
Message-ID: <1424468908.24292.10.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-02-20 at 20:54 +0100, Uwe Kleine-K?nig wrote:
> On Fri, Feb 20, 2015 at 07:01:03PM +0100, Maxime Coquelin wrote:
> > This patch adds clocksource support for ARMv7-M's System timer,
> > also known as SysTick.
> > 
> > Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > ---
> >  drivers/clocksource/Kconfig          |  7 ++++
> >  drivers/clocksource/Makefile         |  1 +
> >  drivers/clocksource/armv7m_systick.c | 78 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 86 insertions(+)
> >  create mode 100644 drivers/clocksource/armv7m_systick.c
> > 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index fc01ec2..fb6011e 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -124,6 +124,13 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> >  	help
> >  	 Use ARM global timer clock source as sched_clock
> >  
> > +config ARMV7M_SYSTICK
> > +	bool
> I assume this symbol is enabled later in the series.

Yes, I noticed it was selected in 14/18 ("ARM: Add STM32 family
machine").

> Would it make sense
> to allow enabing the symbol for compile test coverage?
> 
> > +	select CLKSRC_OF if OF
> What happens if ARMV7M_SYSTICK=y but OF=n? Doesn't the driver fail to
> compile?
> 
> > +	select CLKSRC_MMIO
> > +	help
> > +	  This options enables support for the ARMv7M system timer unit
> the right spelling is ARMv7-M.

This Kconfig entry has no prompt, so no one is going to see this text
during make *config. Perhaps this should be made a comment. In that case
the right spelling should still be used.

Thanks,


Paul Bolle
