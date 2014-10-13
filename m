From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Oct 2014 12:57:22 +0200
Subject: [RFC 2/7] clocksource: add dependencies for Vybrid pit clocksource
In-Reply-To: <98ca2b7a76dc786a36cf6c4113ca751f@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <603e0f51e88b5643cb42e966cbb1b80b21a55ecf.1413136383.git.stefan@agner.ch>
 <20141012181821.GQ31554@pengutronix.de>
 <98ca2b7a76dc786a36cf6c4113ca751f@agner.ch>
Message-ID: <20141013105722.GS31554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Mon, Oct 13, 2014 at 11:46:06AM +0200, Stefan Agner wrote:
> >> --- a/drivers/clocksource/Kconfig
> >> +++ b/drivers/clocksource/Kconfig
> >> @@ -146,6 +146,8 @@ config FSL_FTM_TIMER
> >>
> >>  config VF_PIT_TIMER
> >>  	bool
> >> +	select CLKSRC_MMIO
> >> +	select CLKSRC_OF
> >>  	help
> >>  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
> > This one seems to qualify as a fix for the MMU stuff, right?
> 
> Well, this appeared when working on the !MMU stuff. Because on the MMU
> SoC, CLKSRC_OF is selected by ARCH_MULTIPLATFORM and CLKSRC_MMIO is
> selected by ARCH_MXC, it would not be a problem for MMU SOC_VF610. But I
> guess we should try to define dependencies on the lowest level, so it is
> probably a general fix?
Just notice that VF_PIT_TIMER isn't user selectable, so it's at least
not urgent.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
