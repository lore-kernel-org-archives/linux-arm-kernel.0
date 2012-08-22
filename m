From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 22 Aug 2012 14:04:26 +0200
Subject: [RFC 0/4] ARM: dma-mapping: IOMMU atomic allocation
In-Reply-To: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <005901cd805e$4afd2e40$e0f78ac0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Wednesday, August 22, 2012 12:20 PM Hiroshi Doyu wrote:

> The commit e9da6e9 "ARM: dma-mapping: remove custom consistent dma
> region" breaks the compatibility with existing drivers. This causes
> the following kernel oops(*1). That driver has called dma_pool_alloc()
> to allocate memory from the interrupt context, and it hits
> BUG_ON(in_interrpt()) in "get_vm_area_caller()". This patch seris
> fixes this problem with making use of the pre-allocate atomic memory
> pool which DMA is using in the same way as DMA does now.
> 
> Any comment would be really appreciated.

I was working on the similar patches, but You were faster. ;-)

Basically the patch no 1 and 2 are fine, but I don't like the changes proposed in 
patch 3 and 4. You should not alter the attributes provided by the user nor make any
assumptions that such attributes has been provided - drivers are allowed to call 
dma_alloc_attrs() directly. Please rework your patches to avoid such approach.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
