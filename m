From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Jan 2010 15:25:23 +0000
Subject: [PATCH 1/3] ARM: SAMSUNG: Add config option for number of
	additional GPIO pins.
In-Reply-To: <20100112001526.GH1224@trinity.fluff.org>
References: <1263203046-29219-1-git-send-email-kgene.kim@samsung.com>
	<20100111103338.GA3440@sirena.org.uk>
	<20100111122715.GG1224@trinity.fluff.org>
	<20100111124927.GB27161@rakim.wolfsonmicro.main>
	<20100112001526.GH1224@trinity.fluff.org>
Message-ID: <20100112152523.GL1418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 12:15:26AM +0000, Ben Dooks wrote:
> On Mon, Jan 11, 2010 at 12:49:27PM +0000, Mark Brown wrote:

> > If that gets to be anything other than an extremely niche use case the
> > GPIO allocation would need to have a dynamic limit anyway, though.

> Yes, however a kconfig case where you can set the minimum value of an
> integer would make the whole extra-gpio configuration much cleaner and
> avoid having toadd further configuration symbols when someone wants an
> extra 256 or whatever GPIOS.

Yes, it'd be very much nicer if Kconfig supported that sort of
dependency but without that the hack with selects does seem about as
good as it gets if you want to do it via Kconfig.  I rather suspect this
is why it's common to have an ifdef tree for these things rather than
trying to push them through Kconfig.
