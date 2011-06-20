From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Jun 2011 17:23:22 +0200
Subject: [PATCH 4/8] ARM: dma-mapping: implement dma sg methods on top of
	generic dma ops
In-Reply-To: <20110620144012.GE26089@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
	<20110620144012.GE26089@n2100.arm.linux.org.uk>
Message-ID: <000801cc2f5d$fdd720a0$f98561e0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 20, 2011 4:40 PM Russell King - ARM Linux wrote:

> On Mon, Jun 20, 2011 at 09:50:09AM +0200, Marek Szyprowski wrote:
> > This patch converts all dma_sg methods to be generic (independent of the
> > current DMA mapping implementation for ARM architecture). All dma sg
> > operations are now implemented on top of respective
> > dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.
> 
> No.  We really don't want to do this.

I assume you want to keep the current design for performance reasons?

It's really not a problem for me. I can change my patches to keep 
arm_dma_*_sg_* functions and create some stubs for dmabounce version.

> If we want to move the dsb() out of the mapping functions (which I
> have a patch for) to avoid doing a dsb() on each and every sg segment,
> then we must not use the generic stuff.

Ok, specialized (optimized) version of dma_*_sg_* operations are definitely
better. The current version just calls respective dma_single_* operations in
a loop, so in my patches I decided to create some generic version just to
simplify the code. 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
