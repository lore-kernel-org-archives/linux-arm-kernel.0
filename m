From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 10:58:21 +0200
Subject: [PATCH v2 5/7] iommu/dma: Respect bus DMA limit for IOVAs
In-Reply-To: <d370670edae9c9c537a5280c5e7c96bf3ec7ed8f.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <d370670edae9c9c537a5280c5e7c96bf3ec7ed8f.1532382222.git.robin.murphy@arm.com>
Message-ID: <20180726085821.GB23310@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 11:16:10PM +0100, Robin Murphy wrote:
> Bonus question: Now that we're collecing DMA API code in kernel/dma/
> do we want to reevaluate dma-iommu? On the one hand it's the bulk of a
> dma_ops implementation so should perhaps move, but on the other it's
> entirely IOMMU-specific code so should perhaps stay where it is... :/

I think drivers/iommu/ is the right place for it.  Higher priorities
would be to actually make it a complete dma_map_ops implementation,
which should be doable by next merge window, and to actually use it
for non-arm(64) iommu drivers..
