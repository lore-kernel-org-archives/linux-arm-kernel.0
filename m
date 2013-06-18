From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 14:51:50 +0200
Subject: DMA mapping API(IOMMU) for ARM64?
In-Reply-To: <20130618.140137.1551430695673122122.hdoyu@nvidia.com>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
 <5159282.rrJMaZuYMv@wuerfel>
 <20130618.140137.1551430695673122122.hdoyu@nvidia.com>
Message-ID: <201306181451.50820.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Hiroshi Doyu wrote:
> I'm guessing that this kind of unification usually takes some time
> since we need to factor out the common code from the different
> ${ARCH}/mm/dma-mapping.c. Also some of ${ARCH} has IOMMU support in
> it. So if we want to develop our 64-bit ARM with working DMA mapping
> API during this transition, the step to take would be:
> 
> 1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c(+swiotlb)

Please don't.

> 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
> 3, Factor out the common code from them into mm/dma-mapping.c

I would suggest moving the ARM dma-mapping.c code to /mm or /lib
right away and then generalizing it there. Whoever wants to add
support for their architecture can modify the code to add whatever
changes they require.

	Arnd
