From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 11:38:20 +0100
Subject: [RFC PATCH 0/3] base board consolidation
In-Reply-To: <CACTFLAPsaiF8KEXeDGOX72dcAvzegHDUQcPEPNxywwYewrHsUw@mail.gmail.com>
References: <20110701094403.GT11559@pengutronix.de>
	<20110704082722.GM21898@n2100.arm.linux.org.uk>
	<CACTFLAPsaiF8KEXeDGOX72dcAvzegHDUQcPEPNxywwYewrHsUw@mail.gmail.com>
Message-ID: <20110704103820.GC8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 12:20:08PM +0200, Daniel Mack wrote:
> Yes, I would also much more like to see these boards being supported
> by DT, and eventually, we can probably provide static tree definitions
> for these boards and get rid of the whole code entirely.

While some of that can be done, I think the idea of getting rid of all
the code is a pipedream - things like detecting the LCD panel is
something which has to be in code.

Having separate DT blobs because you happen to have connected a different
LCD display is not sane when you can detect the LCD type at run time -
from either the support perspective or the maintainence perspective.

There's also a similar issue where the ethernet controller may be of
two different types, which can only be detected at runtime - and again
having different DT blobs would be a nightmare.

With that alone, you're talking about 10 different DT blobs (5 different
CLCD panel configs + 2 ethernet configs) for just one Realview board.

There's also the matter of the platform specific registers setting the
clock speed for the SP804 timers.

So no, I don't think that we'll ever get rid of all the code for ARMs
development platforms without losing functionality/utility, but we should
be able to get rid of quite an amount like I've already done by
consolidating across the entire set with plat-versatile.
