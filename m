From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 18 Jun 2013 04:39:55 +0200
Subject: DMA mapping API(IOMMU) for ARM64?
Message-ID: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Currently ARM64 supports swiotlb only as below[1]. AFAIU, swiotlb
provides some kind of bounce buffer for some restricted H/Ws, and it
cannot replace IOMMU H/W completely. So I'm wondering that we would
need the IOMMU versions of dma_map_ops as Marek did for ARM32. If my
understanding is correct, do you guys have any idea how it's going to
be implemented? Can we reuse the current version of "iommu_ops" in
"arch/arm/mm/dma-mapping.c" for ARM64 as well? Or do we need to
rewrite 64bit version of iommu_ops completely in the same file as one
with swiotlb, "arch/arm64/mm/dma-mapping.c"?

Any feedback would be really appreciated.

[1]:
commit 09b55412469dfe6797244dc5836c17ed0c2f191b
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Mon Mar 5 11:49:30 2012 +0000

    arm64: DMA mapping API
    
    This patch adds support for the DMA mapping API. It uses dma_map_ops for
    flexibility and it currently supports swiotlb. This patch could be
    simplified further if the DMA accesses are coherent (not mandated by the
    architecture) or if corresponding hooks are placed in the generic
    swiotlb code to deal with cache maintenance.
