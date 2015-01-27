From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 27 Jan 2015 10:11:00 +0000
Subject: [PATCH v3 08/13] pm: at91: the standby mode uses the same sram
 function as the suspend to memory mode
In-Reply-To: <20150127100824.GC32121@gradator.net>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
 <1422338300-5984-1-git-send-email-wenyou.yang@atmel.com>
 <20150127100824.GC32121@gradator.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD35F4B@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

Thanks a lot.

> -----Original Message-----
> From: Sylvain Rochet [mailto:sylvain.rochet at finsecur.com]
> Sent: Tuesday, January 27, 2015 6:08 PM
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; alexandre.belloni at free-electrons.com;
> peda at axentia.se; sergei.shtylyov at cogentembedded.com; linux at maxim.org.za
> Subject: Re: [PATCH v3 08/13] pm: at91: the standby mode uses the same sram
> function as the suspend to memory mode
> 
> Hello Wenyou,
> 
> On Tue, Jan 27, 2015 at 01:58:20PM +0800, Wenyou Yang wrote:
> >
> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
> > 0377c0d..d967c31 100644
> > --- a/arch/arm/mach-at91/pm.c
> > +++ b/arch/arm/mach-at91/pm.c
> > @@ -71,7 +71,7 @@ static int at91_pm_begin(suspend_state_t state)
> >   * Verify that all the clocks are correct before entering
> >   * slow-clock mode.
> >   */
> > -static int at91_pm_verify_clocks(void)
> > +static int at91_pm_verify_clocks(suspend_state_t state)
> >  {
> >  	unsigned long scsr;
> >  	int i;
> > @@ (...)
> 
> Unused state argument, it was added in v2, this is just a trace of a reverted v2
> change not fully cleaned.

Yes, not clear.
> 
> 
> > +		if (!at91_pm_verify_clocks(state))
> > +			goto error;
> 
> Ditto.
> 
> 
> Sylvain

Best Regards,
Wenyou Yang
