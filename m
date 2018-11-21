From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 21 Nov 2018 17:43:44 +0000
Subject: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
In-Reply-To: <01000167375a15f8-362aa1e2-cf01-49b5-92b5-f0a4efcca477-000000@email.amazonses.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-4-drinkcat@chromium.org>
 <20181121164638.GD24883@arm.com>
 <01000167375a15f8-362aa1e2-cf01-49b5-92b5-f0a4efcca477-000000@email.amazonses.com>
Message-ID: <a034e2c3-8933-caba-a113-ca08372da2b9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/2018 17:38, Christopher Lameter wrote:
> On Wed, 21 Nov 2018, Will Deacon wrote:
> 
>>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
> 
> SLAB_CACHE_DMA32??? WTH is going on here? We are trying to get rid of
> the dma slab array.

See the previous two patches in this series. If there's already a 
(better) way to have a kmem_cache which allocates its backing pages with 
GFP_DMA32, please do let us know.

Robin.
