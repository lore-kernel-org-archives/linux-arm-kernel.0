From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Nov 2009 11:32:12 +0000
Subject: [PATCH 09/19] drivers: serial: add support for Samsung S5PC110
	SoC uart
In-Reply-To: <1b68c6790911190326r38661a55iebcd4ac28a5b8a81@mail.gmail.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-10-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
	<20091118221345.GB4808@trinity.fluff.org>
	<1b68c6790911181844p3fb32525h11f79f942afb2d64@mail.gmail.com>
	<20091119103336.GB15460@sirena.org.uk>
	<1b68c6790911190305w33e777e3n1ed6b172d67f1639@mail.gmail.com>
	<20091119110827.GE9763@rakim.wolfsonmicro.main>
	<1b68c6790911190326r38661a55iebcd4ac28a5b8a81@mail.gmail.com>
Message-ID: <20091119113212.GG9763@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 08:26:34PM +0900, jassi brar wrote:

> The case here is that UART controller can source from various platform clocks
> to generate the UART clocks. The drivers/serial/samsung.c chooses a source
> clock that can result in closest match to the requested rate.
> How could we do that from machine code(except for writing callbacks for each
> machine using the SoC)?

> Or maybe i cud understand better looking at some example.
> Cud u suggest some please?

I can't think off the top of my head of anything which does this
dynamically (rather than just choosing a clock at startup time).  OMAP
might have something since they seem to have the most advanced of the
current implementations.

Off the top of my head it sounds like the muxing ought to be pushed into
the clock API completely - the problem of picking the best match for the
current use case isn't unique to the serial driver by any stretch of the
imagination.  The serial driver would then end up just seeing the output
of the mux it uses, with the clock API dealing with working out which of
the sources can deliver the best match.
