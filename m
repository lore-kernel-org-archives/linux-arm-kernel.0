From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 2 Dec 2014 13:05:39 +0100
Subject: [PATCH] iommu: Decouple iommu_map_sg from CPU page size
In-Reply-To: <2d38d270a532b52f73a720572f8f085dfa08321e.1416936761.git.robin.murphy@arm.com>
References: <2d38d270a532b52f73a720572f8f085dfa08321e.1416936761.git.robin.murphy@arm.com>
Message-ID: <20141202120539.GB32294@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 05:50:55PM +0000, Robin Murphy wrote:
> If the IOMMU supports pages smaller than the CPU page size, segments
> which lie at offsets within the CPU page may be mapped based on the
> finer-grained IOMMU page boundaries. This minimises the amount of
> non-buffer memory between the CPU page boundary and the start of the
> segment which must be mapped and therefore exposed to the device, and
> brings the default iommu_map_sg implementation in line with
> iommu_map/unmap with respect to alignment.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Hi Joerg,
> 
> I noticed this whilst wiring up DMA mapping to this new API - on arm64
> we anticipate running 4k IOMMU pages with 64k CPU pages, in which case
> the alignment check ends up being unnecessarily strict.

Applied to the core branch, thanks.


	Joerg
