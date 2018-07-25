From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jul 2018 13:29:29 +0200
Subject: [PATCH v2 2/7] dma-mapping: Generalise dma_32bit_limit flag
In-Reply-To: <c1720f0181b66f711e4097d85149757b16a7b0a7.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <c1720f0181b66f711e4097d85149757b16a7b0a7.1532382222.git.robin.murphy@arm.com>
Message-ID: <20180725112929.GA24736@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 11:16:07PM +0100, Robin Murphy wrote:
> Whilst the notion of an upstream DMA restriction is most commonly seen
> in PCI host bridges saddled with a 32-bit native interface, a more
> general version of the same issue can exist on complex SoCs where a bus
> or point-to-point interconnect link from a device's DMA master interface
> to another component along the path to memory (often an IOMMU) may carry
> fewer address bits than the interfaces at both ends nominally support.
> In order to properly deal with this, the first step is to expand the
> dma_32bit_limit flag into an arbitrary mask.
> 
> To minimise the impact on existing code, we'll make sure to only
> consider this new mask valid if set. That makes sense anyway, since a
> mask of zero would represent DMA not being wired up at all, and that
> would be better handled by not providing valid ops in the first place.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
