From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 27 Jan 2015 04:44:59 +0000
Subject: [PATCH v2 07/12] pm: at91: the standby mode uses the same sram
 function as the suspend to memory mode
In-Reply-To: <20150126100955.GA18907@gradator.net>
References: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
 <1422265331-23236-1-git-send-email-wenyou.yang@atmel.com>
 <20150126100955.GA18907@gradator.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD35CD3@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

> -----Original Message-----
> From: Sylvain Rochet [mailto:sylvain.rochet at finsecur.com]
> Sent: Monday, January 26, 2015 6:10 PM
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; alexandre.belloni at free-electrons.com;
> peda at axentia.se
> Subject: Re: [PATCH v2 07/12] pm: at91: the standby mode uses the same sram
> function as the suspend to memory mode
> 
> Hello Wenyou,
> 
> 
> On Mon, Jan 26, 2015 at 05:42:11PM +0800, Wenyou Yang wrote:
> > +static int at91_pm_verify_clocks(suspend_state_t state)
> >  {
> >  	unsigned long scsr;
> >  	int i;
> >
> > +	/* For PM_SUSPEND_STANDBY, skip verifying the clock */
> > +	if (state == PM_SUSPEND_STANDBY)
> > +		return 1;
> > +
> 
> In my opinion we should use the select() already in place in
> at91_pm_enter() to do that:
Accepted. Thanks

> 
> >  static int at91_pm_enter(suspend_state_t state)  {
> >  	at91_pinctrl_gpio_suspend();
> >
> >  	switch (state) {
>      (...)
> > +	case PM_SUSPEND_MEM:
> 
> 	/*
> 	 * Ensure that clocks are in a valid state.
> 	 */
> 	if (!at91_pm_verify_clocks())
> 		goto error;
> 	/* FALLTHROUGH */
> 
> > +	case PM_SUSPEND_STANDBY:
> >  		/*
> > -		 * Suspend-to-RAM is like STANDBY plus slow clock mode, so
> 
> 
> Sylvain

Best Regards,
Wenyou Yang
