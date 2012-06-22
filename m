From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2012 09:59:11 +0100
Subject: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
Message-ID: <20120622085911.GA19026@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three patches add support for returning the residue and cyclic DMA
support to the OMAP DMA engine driver.

As v3.5-rc is horribly broken on my OMAP platforms, I've had to back out
all the sound/soc/omap changes from the last merge window to test this,
inspite of Peter Ujfalusi maintaining that there is nothing wrong.  I
can't get working audio support on the OMAP4430SDP any other way.

I am planning no further work on this until OMAP ASoC support gets fixed;
due to Peter and my plans this summer, this is likely to be late July/
August time.

This does not implement all of the weird and wonderfully different DMA
setups which the OMAP ASoC driver appears to support (do we need soo much
flexibility?) but it does support whatever is required for my OMAP4430SDP
board.

These patches apply on top of the previously posted series of DMA patches.

I will be merging at least some of these down into the "dmaengine: add
OMAP DMA engine driver" commit at some point.

 drivers/dma/omap-dma.c |  167 ++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 156 insertions(+), 11 deletions(-)
