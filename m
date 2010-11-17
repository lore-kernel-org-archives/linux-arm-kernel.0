From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Nov 2010 08:38:42 +0000
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <AANLkTi=pa+oa3GXr5vfBtdrfnHpRc_2cwgBYQLJRvYXM@mail.gmail.com>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
	<1289940829.3860.22.camel@localhost.localdomain>
	<AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
	<20101116223116.GG21926@n2100.arm.linux.org.uk>
	<AANLkTi=pa+oa3GXr5vfBtdrfnHpRc_2cwgBYQLJRvYXM@mail.gmail.com>
Message-ID: <20101117083842.GA32476@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 09:34:56AM +0100, Linus Walleij wrote:
> And the Tegra code in mach-tegra/timer.c:
> 
> static cycle_t tegra_clocksource_read(struct clocksource *cs)
> {
>         return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US));
> }
> 
> This just won't fly for long either, the mult for the clocksource is
> usually something in the order of 20.

I thought John/Thomas said that using cnt32_to_63 in there wasn't a good
idea - sounds like it needs to be killed.  Colin?
