From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Mar 2017 15:45:26 +0000
Subject: [PATCH v5] arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
 IOMMU
In-Reply-To: <1488908612-22522-1-git-send-email-geert+renesas@glider.be>
References: <1488908612-22522-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170321154526.GA21829@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 06:43:32PM +0100, Geert Uytterhoeven wrote:
> Add support for allocating physically contiguous DMA buffers on arm64
> systems with an IOMMU.  This can be useful when two or more devices
> with different memory requirements are involved in buffer sharing.
> 
> Note that as this uses the CMA allocator, setting the
> DMA_ATTR_FORCE_CONTIGUOUS attribute has a runtime-dependency on
> CONFIG_DMA_CMA, just like on arm32.
> 
> For arm64 systems using swiotlb, no changes are needed to support the
> allocation of physically contiguous DMA buffers:
>   - swiotlb always uses physically contiguous buffers (up to
>     IO_TLB_SEGSIZE = 128 pages),
>   - arm64's __dma_alloc_coherent() already calls
>     dma_alloc_from_contiguous() when CMA is available.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Queued for 4.12. Thanks.

-- 
Catalin
