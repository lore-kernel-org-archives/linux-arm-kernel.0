From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Nov 2013 15:58:34 +0100
Subject: [PATCH v5 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <20131105132739.GO14892@pengutronix.de>
References: <20131105083336.GK14892@pengutronix.de>
 <201311051326.31999.arnd@arndb.de> <20131105132739.GO14892@pengutronix.de>
Message-ID: <201311051558.35392.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 November 2013, Uwe Kleine-K?nig wrote:
> On Tue, Nov 05, 2013 at 01:26:31PM +0100, Arnd Bergmann wrote:

> > I know we can't kill all of them, but there are still a few in the list above
> > that can be made to use clocksource, and I'm fine with keeping the list
> > around for the ones that really can't. The comment should probably be
> > clearer, but it was more intended for people with random out-of-tree platform
> > code that should be converted to use clocksource.
> droping the CLOCK_TICK_RATE cpp symbol and converting to clocksource
> doesn't necessarily need to go hand in hand, do they? If yes, can you
> please point out the non-trivial use of CLOCK_TICK_RATE?

The last time I had a closer look at this file, defining CLOCK_TICK_RATE
was required for calculating ACT_HZ as the basis for accurate timekeeping
in the absence of a full clocksource driver. That seems to be no longer
the case, I know we talked about getting rid of this particular use
of CLOCK_TICK_RATE in the past, but I don't currently remember what
exactly happened.

	Arnd
