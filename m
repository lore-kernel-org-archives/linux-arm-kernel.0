From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 17 Jul 2012 12:53:38 +0200 (CEST)
Subject: [PATCH/RFC 0/4] dma: Add multiplexer call-back for channel allocation
Message-ID: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

As recently [1] proposed, a DMA channel multiplexer can be user to 
flexibly allocate DMA channels without a use of a DMAC-specific filter 
function. This patch set presents a possible implementation. Of the 3 
patches in this series the first one is the actual proposal, the other two 
are an illustration, using the shdma dmaengine and the sh_mmcif mmc 
drivers on the sh7372 mackerel board.

This is an RFC, please, comment. One extension, that seems to make sense 
is an addition of a multiplexer-configure call-back to actually configure 
the routing. It isn't needed in the shdma case, so, I didn't want to add 
it without real users. Something along the lines of

	struct dma_chan *(*route_chan)(struct dma_chan *, struct device *,
				enum dma_transfer_direction, const char *);

perhaps?

Thanks
Guennadi

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/75828/focus=76295
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
