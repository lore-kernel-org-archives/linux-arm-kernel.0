From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 May 2015 11:29:38 +0100
Subject: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched
 clock' capability
In-Reply-To: <1431078730.13593.14.camel@x220>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>
 <1431078730.13593.14.camel@x220>
Message-ID: <20150508102938.GD29044@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 May 2015, Paul Bolle wrote:

> On Fri, 2015-05-08 at 10:36 +0100, Lee Jones wrote:
> > On Fri, 08 May 2015, Paul Bolle wrote:
> > > On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > > 
> > > > +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> > > > +	bool
> > > > +	depends on CLKSRC_ST_LPC
> > > > +	default y
> > > > +	help
> > > > +	  Use Low Power controller timer clock source as sched_clock
> > > 
> > > This adds, as far as I can see, a Kconfig symbol that will always be in
> > > lockstep with CLKSRC_ST_LPC. Ie, CLKSRC_ST_LPC and
> > > CLKSRC_ST_LPC_TIMER_SCHED_CLOCK will always both be 'n' or both be 'y'.
> > > 
> > > Are there plans to break that lockstep in the future?
> > 
> > What's stopping CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=n?
> 
> If CLKSRC_ST_LPC=y you mean? The lack of a prompt, I'd say. Ie, you
> would need
> 	bool "A very short description"
> 
> to be able to set these independently.
> 
> But now I notice that I missed that there appears to be a problem with
> CLKSRC_ST_LPC too. I'll reply to 2/12 shortly.

Ah, you mean from menuconfig.  I almost forgot what that was. ;)

I can add a menu option, no problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
