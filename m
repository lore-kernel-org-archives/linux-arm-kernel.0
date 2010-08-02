From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Mon, 2 Aug 2010 18:20:01 +0900
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100802090326.GA30670@n2100.arm.linux.org.uk>
References: <1280736182.1902.55.camel@pasglop>
	<20100802172941C.fujita.tomonori@lab.ntt.co.jp>
	<20100802090326.GA30670@n2100.arm.linux.org.uk>
Message-ID: <20100802181919J.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Aug 2010 10:03:26 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Aug 02, 2010 at 05:30:26PM +0900, FUJITA Tomonori wrote:
> > ARM's iommu code (arch/plat-omap/include/plat/iommu.h) is a library to
> > simplify the IOMMU implementations. It could be useful for all the
> > iommu implementations.
> 
> ITYM OMAP's iommu code.

Yeah, I meant that we could extend it to make it useful for other
iommu implementations. At least, we could make something generic like
struct iommu_functions, I think. Then we can embed a generic iommu
structure into an iommu specific struct (like we do with inode).

The current iommu-api (include/linux/iommu.h) is just about domain and
mapping concept. We can implement it on the top of the above
infrastructure.

I'm still trying to figure out how the DMA-API can work well with
them.
