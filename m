From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Dec 2010 11:58:08 +0100
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <20101223100642.GD3636@n2100.arm.linux.org.uk>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
Message-ID: <00ea01cba290$4d67f500$e837df00$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, December 23, 2010 11:07 AM Russell King - ARM Linux wrote:

> On Thu, Dec 23, 2010 at 06:30:57PM +0900, Kyungmin Park wrote:
> > Hi Andrew,
> >
> > any comments? what's the next step to merge it for 2.6.38 kernel. we
> > want to use this feature at mainline kernel.
> 
> Has anyone addressed my issue with it that this is wide-open for
> abuse by allocating large chunks of memory, and then remapping
> them in some way with different attributes, thereby violating the
> ARM architecture specification?

Actually this contiguous memory allocator is a better replacement for
alloc_pages() which is used by dma_alloc_coherent(). It is a generic
framework that is not tied only to ARM architecture.

> In other words, do we _actually_ have a use for this which doesn't
> involve doing something like allocating 32MB of memory from it,
> remapping it so that it's DMA coherent, and then performing DMA
> on the resulting buffer?

This is an arm specific problem, also related to dma_alloc_coherent()
allocator. To be 100% conformant with ARM specification we would
probably need to unmap all pages used by the dma_coherent allocator
from the LOW MEM area. This is doable, but completely not related
to the CMA and this patch series.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
