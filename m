From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 29 Mar 2011 11:20:33 +0530
Subject: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup timer and
	debug counters
In-Reply-To: <20110328210046.GE30616@atomide.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
	<1301304157-2466-15-git-send-email-santosh.shilimkar@ti.com>
	<20110328210046.GE30616@atomide.com>
Message-ID: <ec4e3850d3e0eda0d06986c06cf76601@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Tuesday, March 29, 2011 2:31 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; rnayak at ti.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup
> timer and debug counters
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 02:21]:
> > --- a/arch/arm/mach-omap2/pm-debug.c
> > +++ b/arch/arm/mach-omap2/pm-debug.c
> > @@ -40,6 +41,11 @@ static int omap4_pm_suspend(void)
> >  	int state, ret = 0;
> >  	u32 cpu_id = smp_processor_id();
> >
> > +	/* Wakeup timer from suspend */
> > +	if (wakeup_timer_seconds || wakeup_timer_milliseconds)
> > +		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
> > +					 wakeup_timer_milliseconds);
> > +
> >  	/* Save current powerdomain state */
> >  	list_for_each_entry(pwrst, &pwrst_list, node) {
> >  		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst-
> >pwrdm);
>
> This hack to mess diretly with sys_timer will be ripped out,
> so please drop this patch.
>
Ok.

> In the long run we'll have dmtimer1 dedicated to the PM code,
> so then it's possible to do similar things.
>

Regards,
Santosh
