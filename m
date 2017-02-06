From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 6 Feb 2017 13:14:31 +0100
Subject: [PATCH] iommu/dma: Remove bogus dma_supported() implementation
In-Reply-To: <143b03c101e727cb156b26a907c8d7e390eb9114.1485971565.git.robin.murphy@arm.com>
References: <143b03c101e727cb156b26a907c8d7e390eb9114.1485971565.git.robin.murphy@arm.com>
Message-ID: <20170206121431.GB25981@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 05:53:04PM +0000, Robin Murphy wrote:
> Back when this was first written, dma_supported() was somewhat of a
> murky mess, with subtly different interpretations being relied upon in
> various places. The "does device X support DMA to address range Y?"
> uses assuming Y to be physical addresses, which motivated the current
> iommu_dma_supported() implementation and are alluded to in the comment
> therein, have since been cleaned up, leaving only the far less ambiguous
> "can device X drive address bits Y" usage internal to DMA API mask
> setting. As such, there is no reason to keep a slightly misleading
> callback which does nothing but duplicate the current default behaviour;
> we already constrain IOVA allocations to the iommu_domain aperture where
> necessary, so let's leave DMA mask business to architecture-specific
> code where it belongs.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied, thanks
