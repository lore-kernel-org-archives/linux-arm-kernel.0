From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Oct 2015 16:57:50 +0100
Subject: [PATCH v4 3/6] iommu: add ARM short descriptor page table
 allocator.
In-Reply-To: <1442931167.17514.39.camel@mhfsdcap03>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
 <1438597279-2937-4-git-send-email-yong.wu@mediatek.com>
 <20150916155824.GM28771@arm.com>
 <1442501662.8145.151.camel@mhfsdcap03>
 <1442931167.17514.39.camel@mhfsdcap03>
Message-ID: <20151009155750.GS26278@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 03:12:47PM +0100, Yong Wu wrote:
>      I would like to show you a problem I met, The recursion here may
> lead to stack overflow while we test FHD video decode.
> 
>     From the log, I get the internal variable in the error case: the
> "size" is 0x100000, the "iova" is 0xfea00000, but at that time the
> "blk_size" is 0x1000 as it was the map of small-page. so it enter the
> recursion here.
>     
>     After check the unmap flow, there is only a iommu_unmap in
> __iommu_dma_unmap, and it won't check the physical address align in
> iommu_unmap.

That sounds like a bug in __iommu_dma_unmap. Robin?

Will
