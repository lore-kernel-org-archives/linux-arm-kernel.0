From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Jun 2018 16:47:27 +0100
Subject: [PATCH v2] arm64: dma-mapping: clear buffers allocated with
 FORCE_CONTIGUOUS flag
In-Reply-To: <20180612110840.30436-1-m.szyprowski@samsung.com>
References: <CGME20180612110857eucas1p1f5e3b6d984d4fd7e3b3ce31418df546e@eucas1p1.samsung.com>
 <20180612110840.30436-1-m.szyprowski@samsung.com>
Message-ID: <20180618154726.zfhlq4mqkubsu3mn@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Jun 12, 2018 at 01:08:40PM +0200, Marek Szyprowski wrote:
> dma_alloc_*() buffers might be exposed to userspace via mmap() call, so
> they should be cleared on allocation. In case of IOMMU-based dma-mapping
> implementation such buffer clearing was missing in the code path for
> DMA_ATTR_FORCE_CONTIGUOUS flag handling, because dma_alloc_from_contiguous()
> doesn't honor __GFP_ZERO flag. This patch fixes this issue. For more
> information on clearing buffers allocated by dma_alloc_* functions,
> see commit 6829e274a623 ("arm64: dma-mapping: always clear allocated
> buffers").
> 
> Fixes: 44176bb38fa4 ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

I'll queue this patch for -rc2 but I hope a proper fix goes into the CMA
code.

Thanks.

-- 
Catalin
