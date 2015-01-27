From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 27 Jan 2015 03:08:09 +0000
Subject: [PATCH 07/12] pm: at91: the standby mode uses the same sram
 function as the suspend to memory mode
In-Reply-To: <20150123231315.GA32318@piout.net>
References: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
 <1421741825-18226-8-git-send-email-wenyou.yang@atmel.com>
 <20150123165020.GA24210@gradator.net> <20150123231315.GA32318@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD35C16@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: Saturday, January 24, 2015 7:13 AM
> To: Sylvain Rochet
> Cc: Yang, Wenyou; Ferre, Nicolas; linux at arm.linux.org.uk; linux-
> kernel at vger.kernel.org; peda at axentia.se; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 07/12] pm: at91: the standby mode uses the same sram
> function as the suspend to memory mode
> 
> On 23/01/2015 at 17:50:20 +0100, Sylvain Rochet wrote :
> > Hello Wenyou,
> >
> >
> > On Tue, Jan 20, 2015 at 04:17:00PM +0800, Wenyou Yang wrote:
> > >
> > > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
> > > 691e6db..a1010f0 100644
> > > --- a/arch/arm/mach-at91/pm.c
> > > +++ b/arch/arm/mach-at91/pm.c
> >
> >
> > > @@ -145,62 +145,51 @@ extern void at91_slow_clock(void __iomem *pmc,
> void __iomem *ramc0,
> > >  			    void __iomem *ramc1, int memctrl);  extern u32
> > > at91_slow_clock_sz;
> > >
> > > +static void at91_pm_suspend(suspend_state_t state) {
> >       (...)
> > > +	slow_clock(at91_pmc_base, at91_ramc_base[0],
> > > +			at91_ramc_base[1], pm_data);
> > > +}
> >
> >
> > > -			if (slow_clock) {
> > > -				slow_clock(at91_pmc_base, at91_ramc_base[0],
> > > -					   at91_ramc_base[1],
> > > -					   at91_pm_data.memctrl);
> >       (...)
> > > +               at91_pm_suspend(state);
> >
> >
> > By doing that you removed the condition "if (slow_clock)".
> >
> > But slow_clock can still be NULL, see commit d2e4679, there are
> > multiple reasons which ends up with a NULL slow_clock.
> >
> 
> I would fix that by not calling suspend_set_ops(&at91_pm_ops) when slow_clock
> is NULL in patch 6 (quick and easy) or copying the whole
> at91_pm_sram_init() in at91_pm_init() and handle failures from there.
Thank you for suggestion, I will fix it.

> 
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com

Best Regards,
Wenyou Yang
