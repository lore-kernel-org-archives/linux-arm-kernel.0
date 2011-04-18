From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 18 Apr 2011 15:24:29 +0200
Subject: [RFC/PATCH v3 0/7] Samsung IOMMU videobuf2 allocator and s5p-fimc
	update
In-Reply-To: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <003701cbfdcb$f254c020$d6fe4060$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, April 18, 2011 11:27 AM Marek Szyprowski wrote:

> This is a third version of the Samsung IOMMU driver (see patch #2) and
> videobuf2 allocator for IOMMU mapped memory (see patch #4) as well as
> FIMC driver update. This update brings some minor bugfixes to Samsung
> IOMMU (SYSMMU) driver and support for pages larger than 4KiB in
> videobuf2-dma-iommu allocator.

snip

> This patch series contains a collection of patches for various platform
> subsystems. Here is a detailed list:
> 
> [PATCH 1/7] ARM: EXYNOS4: power domains: fixes and code cleanup
> - adds support for block gating in Samsung power domain driver and
>   performs some cleanup
> 
> [PATCH 2/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU) driver
> - a complete rewrite of sysmmu driver for Samsung platform, now uses
>   linux/include/iommu.h api (key patch in this series)
> 
> [PATCH 3/7] v4l: videobuf2: dma-sg: move some generic functions to memops
> - a little cleanup and preparations for the dma-iommu allocator
> 
> [PATCH 4/7] v4l: videobuf2: add IOMMU based DMA memory allocator
> - introduces new memory allocator for videobuf2 for drivers that support
>   iommu dma memory mappings (key patch in this series)

I was in a bit hurry and I forgot to mention that the above patch relies
on some improvements to gen_alloc framework. The required 2 patches can be
found in the following patch series:
https://lkml.org/lkml/2011/3/31/213

"[PATCH 01/12] lib: bitmap: Added alignment offset for
bitmap_find_next_zero_area()"
https://lkml.org/lkml/2011/3/31/211

"[PATCH 02/12] lib: genalloc: Generic allocator improvements"
https://lkml.org/lkml/2011/3/31/207

For easier testing I've uploaded the whole IOMMU patch series and
prerequisites to public GIT repository to vb2-iommu branch (will be
available in a about 2 hours):

http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/vb2-
iommu

git://git.infradead.org/users/kmpark/linux-2.6-samsung vb2-iommu

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
