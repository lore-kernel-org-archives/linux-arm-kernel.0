From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 29 Jul 2013 12:14:15 +0530
Subject: [PATCH 1/3] dmaengine: add dma_get_slave_sg_limits()
In-Reply-To: <51E83A9D.5020008@ti.com>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
 <1374166001-31340-2-git-send-email-joelf@ti.com>
 <20130718170825.GZ21614@n2100.arm.linux.org.uk>
 <51E83A9D.5020008@ti.com>
Message-ID: <20130729064415.GF29095@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 01:57:33PM -0500, Joel Fernandes wrote:
> On 07/18/2013 12:08 PM, Russell King - ARM Linux wrote:
> > As for the maximum number of scatterlist entries, really that's a bug in
> > the DMA engine implementations if they can't accept arbitary lengths.
> > I've created DMA engine drivers for implementations where you have to
> > program each segment individually, ones which can have the current and
> > next segments, as well as those which can walk a list.  Provided you get
> > informed of a transfer being completed, there really is no reason for a
> > DMA engine driver to limit the number of scatterlist entries that it
> > will accept.
> 
> Sure, that makes sense. Can you point to such a typical example
> implementation to get some ideas?
MXS MMC driver uses this: drivers/mmc/host/mxs-mmc.c
And dma engine driver for this is mxs-dma.c

~Vinod
-- 
