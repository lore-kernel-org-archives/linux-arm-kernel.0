From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Nov 2009 11:17:03 +0000
Subject: i.MX audio support
In-Reply-To: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20091120111703.GB20236@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:

> one single FIFO. The WM9712 I worked with sends data in slot 12 which we have
> to sort out manually from the FIFO, so I think there is no way to work around
> the fiq handler using the DMA engine with AC97.

Slot 12 is used for GPIOs to allow them to be read/written without
register accesses - I'd expect that data there will not be uncommon.

> The devdma code is actually a copy of sound/arm/devdma.[ch]. It should probably
> be selected somehow instead of duplicated.

Yes, ideally.  A simple Makefile change in sound/arm should do the
trick.  Other than this I'm happy with all the patches I've not
specifically commented on.
