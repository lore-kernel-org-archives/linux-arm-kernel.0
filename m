From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Jul 2013 09:29:39 -0700
Subject: [PATCH v4 04/17] sched_clock: Add support for >32 bit sched_clock
In-Reply-To: <20130719092319.GA4681@tarshish>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-5-git-send-email-sboyd@codeaurora.org>
 <20130719092319.GA4681@tarshish>
Message-ID: <20130719162939.GG27430@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19, Baruch Siach wrote:
> On Thu, Jul 18, 2013 at 04:21:17PM -0700, Stephen Boyd wrote:
> > @@ -110,14 +123,13 @@ void __init setup_sched_clock(u32 (*read)(void), int
> >   bits, unsigned long rate)
> >  	if (cd.rate > rate)
> >  		return;
> >  
> > -	BUG_ON(bits > 32);
> >  	WARN_ON(!irqs_disabled());
> >  	read_sched_clock = read;
> > -	sched_clock_mask = (1 << bits) - 1;
> > +	sched_clock_mask = CLOCKSOURCE_MASK(bits);
> 
> Note that this conflicts with my integer overflow fix 
> (http://article.gmane.org/gmane.linux.ports.arm.kernel/252498) that I hope 
> will get merged before 3.11 is out.
> 

Thanks for the heads up. The conflict looks minor and I'll rebase
if necessary.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
