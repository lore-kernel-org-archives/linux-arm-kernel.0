From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 05 May 2017 12:01:43 +0200
Subject: [PATCH] arm64: Fix the DMA mmap and get_sgtable API with
 DMA_ATTR_FORCE_CONTIGUOUS
In-Reply-To: <1493143232-2245-1-git-send-email-catalin.marinas@arm.com>
References: <CGME20170425180040epcas4p3d96f58d43c973feefbb31e97b9fb2ace@epcas4p3.samsung.com>
 <1493143232-2245-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <c88b3fe6-f8e6-1409-be45-3c824320c98e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.04.2017 20:00, Catalin Marinas wrote:
> While honouring the DMA_ATTR_FORCE_CONTIGUOUS on arm64 (commit
> 44176bb38fa4: "arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
> IOMMU"), the existing uses of dma_mmap_attrs() and dma_get_sgtable()
> have been broken by passing a physically contiguous vm_struct with an
> invalid pages pointer through the common iommu API.
>
> Since the coherent allocation with DMA_ATTR_FORCE_CONTIGUOUS uses CMA,
> this patch simply reuses the existing swiotlb logic for mmap and
> get_sgtable.
>
> Note that the current implementation of get_sgtable (both swiotlb and
> iommu) is broken if dma_declare_coherent_memory() is used since such
> memory does not have a corresponding struct page. To be addressed in a
> separate patch.
>
> Fixes: 44176bb38fa4 ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Tested-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
