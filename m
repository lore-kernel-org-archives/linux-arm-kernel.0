From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 Apr 2011 11:02:34 +0200
Subject: [PATCH 4/7] v4l: videobuf2: add IOMMU based DMA memory allocator
In-Reply-To: <201104181615.49009.arnd@arndb.de>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
	<1303118804-5575-5-git-send-email-m.szyprowski@samsung.com>
	<201104181615.49009.arnd@arndb.de>
Message-ID: <00ea01cbfe70$860ca900$9225fb00$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, April 18, 2011 4:16 PM Arnd Bergmann wrote:

> On Monday 18 April 2011, Marek Szyprowski wrote:
> > From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> >
> > This patch adds new videobuf2 memory allocator dedicated to devices that
> > supports IOMMU DMA mappings. A device with IOMMU module and a driver
> > with include/iommu.h compatible interface is required. This allocator
> > aquires memory with standard alloc_page() call and doesn't suffer from
> > memory fragmentation issues. The allocator support following page sizes:
> > 4KiB, 64KiB, 1MiB and 16MiB to reduce iommu translation overhead.
> 
> My feeling is that this is not the right abstraction. Why can't you
> just implement the regular dma-mapping.h interfaces for your IOMMU
> so that the videobuf code can use the existing allocators?

I'm not really sure which existing videobuf2 allocators might transparently
support IOMMU interface yet

Do you think that all iommu operations can be hidden behind dma_map_single 
and dma_unmap_single?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
