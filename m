From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 22 Jan 2014 09:39:26 -0500
Subject: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
In-Reply-To: <20140122141905.GQ27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk> <52DFBFDD.8040506@ti.com>
 <20140122141905.GQ27282@n2100.arm.linux.org.uk>
Message-ID: <52DFD81E.1070103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 January 2014 09:19 AM, Russell King - ARM Linux wrote:
> On Wed, Jan 22, 2014 at 06:25:57PM +0530, Sricharan R wrote:
>> Setting up of DMA_DST_SYNC_PREFETCH is missing after this ?
> 
> I'm not looking for the DMA engine driver to be a 100% reimplementation
> of the legacy driver.  Rather than supporting the entire set of features
> which the legacy driver did, and have many of them simply not used, the
> approach I'm taking here is to only support what is necessary for the
> drivers we have in mainline - and what fits the DMA engine interfaces.
> 
+1 on the approach.

> There is no point inventing new DMA engine interfaces for features for
> which we have no users in mainline kernel - to try to do that will be
> quite rightfully thrown out by the DMA engine maintainers.
> 
> Here's the total number of references/definitions of DMA_DST_SYNC_PREFETCH
> in the mainline kernel:
> 
> arch/arm/plat-omap/dma.c:               if (src_or_dst_synch == OMAP_DMA_DST_SYNC_PREFETCH) {
> include/linux/omap-dma.h:#define OMAP_DMA_DST_SYNC_PREFETCH     0x02
> 
> Hence, this feature is unused at present.
> 
I thought the crypto was using the prefetch feature but it isn't. 

Regards,
Santosh
