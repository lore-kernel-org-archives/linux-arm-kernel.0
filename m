From: murphyt7@tcd.ie (Tom Murphy)
Date: Tue, 18 Sep 2018 14:28:55 +0100
Subject: [PATCH v2 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <20180917133359.GA972@lst.de>
References: <cover.1536764440.git.robin.murphy@arm.com>
 <20180914124858.GA4010@arm.com> <20180917133359.GA972@lst.de>
Message-ID: <CALQxJusfn_d0X34RAevfunjj9-dA6_qq97efjUriBZWMJoX4QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Not sure how fast Tom needs the common dma-iommu code for the x86 AMD iommu conversion.

I am currently busy working on something else and won't be able to
do/test the x86 AMD iommu conversion anytime soon. So I don't need the
common dma-iommu code anytime soon.

On 17 September 2018 at 14:33, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Sep 14, 2018 at 01:48:59PM +0100, Will Deacon wrote:
>> > As far as merging goes, I don't mind at all whether this goes via IOMMU,
>> > or via dma-mapping provided Joerg's happy to ack it.
>>
>> I think it makes most sense for Joerg to take this series via his tree.
>
> FYI, I have WIP patches to move the arm dma-iommu wrappers to common
> code:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent
>
> which will require some synchronization of the involved trees.  In the
> end it is iommu code, so the actual iommu patches should probably
> go into the iommu tree after all, but it might have to pull in the
> dma-mapping branch for that.  Or we just punt it until the next merge
> window.  Not sure how fast Tom needs the common dma-iommu code for
> the x86 AMD iommu conversion.
