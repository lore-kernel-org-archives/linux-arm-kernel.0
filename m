From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Nov 2013 14:53:09 +0100
Subject: [PATCH v4 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <1383562853-17202-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
 <1383562853-17202-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201311041453.09897.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 November 2013, Uwe Kleine-K?nig wrote:
> While mach/timex.h isn't used for multi-platform builds it still is for
> "normal" builds. As there are only three platforms that do something else
> than only defining CLOCK_TICK_RATE (and these are probably easy to fix),
> deprecate mach/timex.h and drop the corresponding files.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

+LinusW, +rmk

I don't think we can do this (yet): IIRC, CLOCK_TICK_RATE is required
at least for platforms using CONFIG_ARCH_USES_GETTIMEOFFSET (which
is not allowed for multiplatform).

	Arnd
