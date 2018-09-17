From: hch@lst.de (Christoph Hellwig)
Date: Mon, 17 Sep 2018 15:33:59 +0200
Subject: [PATCH v2 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <20180914124858.GA4010@arm.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
 <20180914124858.GA4010@arm.com>
Message-ID: <20180917133359.GA972@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 01:48:59PM +0100, Will Deacon wrote:
> > As far as merging goes, I don't mind at all whether this goes via IOMMU,
> > or via dma-mapping provided Joerg's happy to ack it.
> 
> I think it makes most sense for Joerg to take this series via his tree.

FYI, I have WIP patches to move the arm dma-iommu wrappers to common
code:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent

which will require some synchronization of the involved trees.  In the
end it is iommu code, so the actual iommu patches should probably
go into the iommu tree after all, but it might have to pull in the
dma-mapping branch for that.  Or we just punt it until the next merge
window.  Not sure how fast Tom needs the common dma-iommu code for
the x86 AMD iommu conversion.
