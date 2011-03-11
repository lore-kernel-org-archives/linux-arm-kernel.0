From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 Mar 2011 10:04:36 +0100
Subject: [PATCH 3/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <201103101552.15536.arnd@arndb.de>
References: <1299229274-9753-4-git-send-email-m.szyprowski@samsung.com>
	<1299254660-15765-1-git-send-email-m.szyprowski@samsung.com>
	<201103101552.15536.arnd@arndb.de>
Message-ID: <002101cbdfcb$5c657820$15306860$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, March 10, 2011 3:52 PM Arnd Bergmann wrote:

> On Friday 04 March 2011, Marek Szyprowski wrote:
> > From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> >
> > This patch performs a complete rewrite of sysmmu driver for Samsung platform:
> > - the new version introduces an api to construct device private page
> >   tables and enables to use device private address space mode
> > - simplified the resource management: no more single platform
> >   device with 32 resources is needed, better fits into linux driver model,
> >   each sysmmu instance has it's own resource definition
> > - added support for sysmmu clocks
> > - some other minor API chages required by upcoming videobuf2 allocator
> >
> > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Please explain why create a new IOMMU API when we already have two
> generic ones (include/linux/iommu.h and include/linux/dma-mapping.h).
> 
> Is there something that cannot be done with the common code?
> The first approach should be to extend the existing APIs to
> do what you need.

We followed the style of iommu API for other mainline ARM platforms (both OMAP and MSM
also have custom API for their iommu modules). I've briefly checked include/linux/iommu.h
API and I've noticed that it has been designed mainly for KVM support. There is also
include/linux/intel-iommu.h interface, but I it is very specific to intel gfx chips.

Is there any example how include/linux/dma-mapping.h interface can be used for iommu
mappings?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
