From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Nov 2013 14:27:39 +0100
Subject: [PATCH v5 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <201311051326.31999.arnd@arndb.de>
References: <20131105083336.GK14892@pengutronix.de>
 <201311051234.43321.arnd@arndb.de>
 <20131105114548.GQ16735@n2100.arm.linux.org.uk>
 <201311051326.31999.arnd@arndb.de>
Message-ID: <20131105132739.GO14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 01:26:31PM +0100, Arnd Bergmann wrote:
> On Tuesday 05 November 2013, Russell King - ARM Linux wrote:
> > On Tue, Nov 05, 2013 at 12:34:42PM +0100, Arnd Bergmann wrote:
> > > config CLOCK_TICK_RATE
> > >       int
> > >       depends on !ARCH_MULTIPLATFORM && ARCH_USES_GETTIMEOFFSET
> > >       depends on ARCH_GEMINI || ARCH_SA1100 || ARCH_EBSA110 || ARCH_EP93XX || ARCH_RPC || ARCH_AT91X40
> > >       default 40000000 if ARCH_AT91X40
> > >       default 38000000 if ARCH_GEMINI
> > >       default 3686400 if ARCH_SA1100
> > >       default 47894000 if ARCH_EBSA110
> > >       default 983040 if ARCH_EP93xx
> > >       default 2000000 if ARCH_RPC
> > >       # don't even think about adding more to this list, better get rid of the
> > >       # existing ones by converting them to proper clocksources
> > 
> > That's a pipedream.  It really is.  Some of those are impossible to
> > convert because you don't have enough timers/counters to provide the
> > clocksource and clockevents - as I've mentioned several times in the
> > past.
> 
> Do you mean removing all of the above is a pipedream, or using Kconfig like that?
> 
> I know we can't kill all of them, but there are still a few in the list above
> that can be made to use clocksource, and I'm fine with keeping the list
> around for the ones that really can't. The comment should probably be
> clearer, but it was more intended for people with random out-of-tree platform
> code that should be converted to use clocksource.
droping the CLOCK_TICK_RATE cpp symbol and converting to clocksource
doesn't necessarily need to go hand in hand, do they? If yes, can you
please point out the non-trivial use of CLOCK_TICK_RATE?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
