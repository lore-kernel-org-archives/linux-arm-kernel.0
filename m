From: hch@lst.de (Christoph Hellwig)
Date: Fri, 27 Jul 2018 16:20:54 +0200
Subject: [PATCH] of/platform: Initialise default DMA masks
In-Reply-To: <9ffa7f2676c25adf39e85ec8114b26500b5680f6.1532699305.git.robin.murphy@arm.com>
References: <9ffa7f2676c25adf39e85ec8114b26500b5680f6.1532699305.git.robin.murphy@arm.com>
Message-ID: <20180727142054.GA29316@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 03:14:15PM +0100, Robin Murphy wrote:
> This shouldn't strictly depend on the changes currently queued in the
> dma-mapping tree, so should be OK to go through the DT tree in parallel.
> Ideally we'd fix all DMA-capable drivers to set their masks correctly,
> but in the short term everyone's going to get cross about -rc1 not
> booting...

I'd prefer to pick this up through the dma-mapping tree, and in fact
move it before the bus_dma_mask changes just to keep a bisectable
tree.
