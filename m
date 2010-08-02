From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Mon, 2 Aug 2010 17:30:26 +0900
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <1280736182.1902.55.camel@pasglop>
References: <1280546124.1902.30.camel@pasglop> <20100802074812.GM24084@amd.com>
	<1280736182.1902.55.camel@pasglop>
Message-ID: <20100802172941C.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Aug 2010 18:03:02 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2010-08-02 at 09:48 +0200, Roedel, Joerg wrote:
> > > Hrm, indeed I just noticed that. Pretty gross... it should definitly
> > be
> > > renamed, is will caused endless confusion with unrelated iommu.h and
> > > iommu_* interfaces which represent something different.
> > 
> > The first direction to go should be trying to unify all the different
> > iommu* interfaces into the iommu-api. The generic api will definitly
> > need to be extended for that, but since it is an in-kernel interface
> > thats no problem. 
> 
> Well, I suppose I'm the de-facto candidate to take care of the powerpc
> side then :-)

We already agreed that what the iommu-api looks like?

ARM's iommu code (arch/plat-omap/include/plat/iommu.h) is a library to
simplify the IOMMU implementations. It could be useful for all the
iommu implementations.

The current iommu-api (include/linux/iommu.h) provides the common
interface for specific purposes (for KVM).

I think that the current iommu-api can be a part of the former.

I also think that the IOMMU part of this new msm should be integrated
into the former.

Another question is how the above can work with the DMA-API.
