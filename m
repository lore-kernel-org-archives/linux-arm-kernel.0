From: corbet@lwn.net (Jonathan Corbet)
Date: Tue, 27 Jul 2010 06:58:42 -0600
Subject: [PATCHv2 2/4] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <003701cb2d89$adae4580$090ad080$%szyprowski@samsung.com>
References: <cover.1280151963.git.m.nazarewicz@samsung.com>
	<743102607e2c5fb20e3c0676fadbcb93d501a78e.1280151963.git.m.nazarewicz@samsung.com>
	<dc4bdf3e0b02c0ac4770927f72b6cbc3f0b486a2.1280151963.git.m.nazarewicz@samsung.com>
	<20100727120841.GC11468@n2100.arm.linux.org.uk>
	<003701cb2d89$adae4580$090ad080$%szyprowski@samsung.com>
Message-ID: <20100727065842.40ae76c8@bike.lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jul 2010 14:45:58 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> > How does one obtain the CPU address of this memory in order for the CPU
> > to access it?  
> 
> Right, we did not cover such case. In CMA approach we tried to separate
> memory allocation from the memory mapping into user/kernel space. Mapping
> a buffer is much more complicated process that cannot be handled in a
> generic way, so we decided to leave this for the device drivers. Usually
> video processing devices also don't need in-kernel mapping for such
> buffers at all.

Still...that *is* why I suggested an interface which would return both
the DMA address and a kernel-space virtual address, just like the DMA
API does...  Either that, or just return the void * kernel address and
let drivers do the DMA mapping themselves.  Returning only the
dma_addr_t address will make the interface difficult to use in many
situations.

jon
