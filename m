From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Nov 2013 09:33:36 +0100
Subject: [PATCH v4 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <201311041453.09897.arnd@arndb.de>
References: <20131104105836.GI14892@pengutronix.de>
 <1383562853-17202-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201311041453.09897.arnd@arndb.de>
Message-ID: <20131105083336.GK14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 02:53:09PM +0100, Arnd Bergmann wrote:
> On Monday 04 November 2013, Uwe Kleine-K?nig wrote:
> > While mach/timex.h isn't used for multi-platform builds it still is for
> > "normal" builds. As there are only three platforms that do something else
> > than only defining CLOCK_TICK_RATE (and these are probably easy to fix),
> > deprecate mach/timex.h and drop the corresponding files.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> +LinusW, +rmk
> 
> I don't think we can do this (yet): IIRC, CLOCK_TICK_RATE is required
> at least for platforms using CONFIG_ARCH_USES_GETTIMEOFFSET (which
> is not allowed for multiplatform).
Hmm, I indeed missed some uses, i.e. ep93xx, mmp, netx, sa1100, u300,
ixp4xx and rpc use CLOCK_TICK_RATE (or LATCH). Also
drivers/rtc/rtc-pxa.c uses CLOCK_TICK_RATE. I didn't find that
ARCH_USES_GETTIMEOFFSET implies a use of CLOCK_TICK_RATE though. Did I
miss something?

For now I took the patch out of my next branch and will rework it to at
least let the above listed platforms also continue to use timex.h.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
