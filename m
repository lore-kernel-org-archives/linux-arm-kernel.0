From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 22 May 2012 16:27:49 +0800
Subject: [Linaro-mm-sig] [GIT PULL] CMA and ARM DMA-mapping updates for
 v3.5
In-Reply-To: <1337672417-10065-1-git-send-email-m.szyprowski@samsung.com>
References: <1337672417-10065-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAGsJ_4xOOuH9FyF-PfitXWCc0JQ9Tnh8g1Tff0TfEdrO0SvXSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

2012/5/22 Marek Szyprowski <m.szyprowski@samsung.com>:
> Hi Linus,
>
> I would like to ask for pulling Contiguous Memory Allocator (CMA) and
> ARM DMA-mapping framework updates for v3.5.
>
> The following changes since commit 76e10d158efb6d4516018846f60c2ab5501900bc:
>
> ?Linux 3.4 (2012-05-20 15:29:13 -0700)
>
> with the top-most commit 0f51596bd39a5c928307ffcffc9ba07f90f42a8b
>
> ?Merge branch 'for-next-arm-dma' into for-linus
>
> are available in the git repository at:
> ?git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git for-linus
>
>
> Patch summary:
>
> Marek Szyprowski (17):
> ? ? ?common: add dma_mmap_from_coherent() function
> ? ? ?ARM: dma-mapping: use dma_mmap_from_coherent()
> ? ? ?ARM: dma-mapping: use pr_* instread of printk
> ? ? ?ARM: dma-mapping: introduce DMA_ERROR_CODE constant
> ? ? ?ARM: dma-mapping: remove offset parameter to prepare for generic dma_ops
> ? ? ?ARM: dma-mapping: use asm-generic/dma-mapping-common.h
> ? ? ?ARM: dma-mapping: implement dma sg methods on top of any generic dma ops
> ? ? ?ARM: dma-mapping: move all dma bounce code to separate dma ops structure
> ? ? ?ARM: dma-mapping: remove redundant code and do the cleanup
> ? ? ?ARM: dma-mapping: use alloc, mmap, free from dma_ops
> ? ? ?ARM: dma-mapping: add support for IOMMU mapper
> ? ? ?mm: extract reclaim code from __alloc_pages_direct_reclaim()
> ? ? ?mm: trigger page reclaim in alloc_contig_range() to stabilise watermarks
> ? ? ?drivers: add Contiguous Memory Allocator
> ? ? ?X86: integrate CMA with DMA-mapping subsystem
> ? ? ?ARM: integrate CMA with DMA-mapping subsystem
> ? ? ?Merge branch 'for-next-arm-dma' into for-linus
>
> Mel Gorman (1):
> ? ? ?mm: Serialize access to min_free_kbytes
>
> Michal Nazarewicz (9):
> ? ? ?mm: page_alloc: remove trailing whitespace
> ? ? ?mm: compaction: introduce isolate_migratepages_range()
> ? ? ?mm: compaction: introduce map_pages()
> ? ? ?mm: compaction: introduce isolate_freepages_range()
> ? ? ?mm: compaction: export some of the functions
> ? ? ?mm: page_alloc: introduce alloc_contig_range()
> ? ? ?mm: page_alloc: change fallbacks array handling
> ? ? ?mm: mmzone: MIGRATE_CMA migration type added
> ? ? ?mm: page_isolation: MIGRATE_CMA isolation functions added
>
> Minchan Kim (1):
> ? ? ?cma: fix migration mode
>
> Vitaly Andrianov (1):
> ? ? ?ARM: dma-mapping: use PMD size for section unmap

would you pls add CMA test module in this patchset too?

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/088412.html

mm: cma: add a simple kernel module as the helper to test CMA

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Reviewed-by: Michal Nazarewicz <mina86@mina86.com>

Thanks
barry
