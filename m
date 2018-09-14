From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Sep 2018 13:48:59 +0100
Subject: [PATCH v2 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <cover.1536764440.git.robin.murphy@arm.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
Message-ID: <20180914124858.GA4010@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Wed, Sep 12, 2018 at 04:24:11PM +0100, Robin Murphy wrote:
> John raised the issue[1] that we have some unnecessary refcount contention
> in the DMA ops path which shows scalability problems now that we have more
> real high-performance hardware using iommu-dma. The x86 IOMMU drivers are
> sidestepping this by stashing domain references in archdata, but since
> that's not very nice for architecture-agnostic code, I think it's time to
> look at a generic API-level solution.
> 
> These are a couple of quick patches based on the idea I had back when
> first implementing iommu-dma, but didn't have any way to justify at the
> time. However, the reports of 10-25% better networking performance on v1
> suggest that it's very worthwhile (and far more significant than I ever
> would have guessed).
> 
> As far as merging goes, I don't mind at all whether this goes via IOMMU,
> or via dma-mapping provided Joerg's happy to ack it.

I think it makes most sense for Joerg to take this series via his tree.

Anyway, I've been running them on my TX2 box and things are happy enough,
so:

Tested-by: Will Deacon <will.deacon@arm.com>

Will
