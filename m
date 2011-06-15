From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2011 13:20:42 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <op.vw31uxxl3l0zgt@mnazarewicz-glaptop>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106142242.25157.arnd@arndb.de>
	<op.vw31uxxl3l0zgt@mnazarewicz-glaptop>
Message-ID: <201106151320.42182.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 June 2011, Michal Nazarewicz wrote:
> On Tue, 14 Jun 2011 22:42:24 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> > * We still need to solve the same problem in case of IOMMU mappings
> >   at some point, even if today's hardware doesn't have this combination.
> >   It would be good to use the same solution for both.
> 
> I don't think I follow.  What does IOMMU has to do with CMA?

The point is that on the higher level device drivers, we want to
hide the presence of CMA and/or IOMMU behind the dma mapping API,
but the device drivers do need to know about the bank properties.

If we want to solve the problem of allocating per-bank memory inside
of CMA, we also need to solve it inside of the IOMMU code, using
the same device driver interface.

	Arnd
