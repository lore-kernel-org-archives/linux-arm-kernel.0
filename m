From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 28 Aug 2012 18:51:00 +0200
Subject: [v4 0/4] ARM: dma-mapping: IOMMU atomic allocation
In-Reply-To: <1346130784-23571-1-git-send-email-hdoyu@nvidia.com>
References: <1346130784-23571-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <503CF6F4.7060702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 8/28/2012 7:13 AM, Hiroshi Doyu wrote:
> The commit e9da6e9 "ARM: dma-mapping: remove custom consistent dma
> region" breaks the compatibility with existing drivers. This causes
> the following kernel oops(*1). That driver has called dma_pool_alloc()
> to allocate memory from the interrupt context, and it hits
> BUG_ON(in_interrpt()) in "get_vm_area_caller()". This patch seris
> fixes this problem with making use of the pre-allocate atomic memory
> pool which DMA is using in the same way as DMA does now.
>
> Any comment would be really appreciated.

Looks fine now. I will do some tests and apply them to my fixes-for-3.6
branch. Thanks for Your contribution!

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
