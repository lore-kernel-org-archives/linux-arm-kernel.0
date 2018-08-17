From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 17 Aug 2018 05:01:13 -0700
Subject: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <74796f9d-5320-ea26-630a-207f4c537c55@arm.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
 <20180817072415.GA22241@infradead.org>
 <74796f9d-5320-ea26-630a-207f4c537c55@arm.com>
Message-ID: <20180817120113.GA31542@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2018 at 12:30:31PM +0100, Robin Murphy wrote:
> On 17/08/18 08:24, Christoph Hellwig wrote:
> > I plan to make the arm iommu dma ops generic and move them to
> > drivers/iommu for the 4.20 merge window.
> 
> You mean 32-bit arm?

Sorry, I meant the arm64 wrappers for dma-iommu of course.

> The only place that code should move to is /dev/null ;)
> - the plan has always been to convert it to use groups and default domains
> so it can just plug iommu-dma in. The tricky bit is either weaning the users
> of the private arm_iommu_*() API onto generic IOMMU API usage, or at least
> implementing transitional wrappers in a way that doesn't break anything.

Agreed on the arm32 iommu code.
