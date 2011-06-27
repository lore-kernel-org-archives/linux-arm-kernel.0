From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Jun 2011 15:30:59 +0200
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method
	to more generic alloc/free_attrs
In-Reply-To: <201106271522.05486.arnd@arndb.de>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<201106241751.35655.arnd@arndb.de>
	<000701cc34c5$0c50b800$24f22800$%szyprowski@samsung.com>
	<201106271522.05486.arnd@arndb.de>
Message-ID: <000801cc34ce$739df1e0$5ad9d5a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 27, 2011 3:22 PM Arnd Bergmann wrote:

> On Monday 27 June 2011, Marek Szyprowski wrote:
> > > On a related note, do you plan to make the CMA work use this
> > > transparently, or do you want to have a DMA_ATTR_LARGE or
> > > DMA_ATTR_CONTIGUOUS for CMA?
> >
> > IMHO it will be better to hide the CMA from the drivers. Memory allocated
> > from CMA doesn't really differ from the one allocated by
> dma_alloc_coherent()
> > (which internally use alloc_pages()), so I really see no reason for
> adding
> > additional attribute for it.
> 
> Ok, fair enough. On a semi-related topic, IIRC we still need to make sure
> that dma_alloc_coherent() pages are unmapped from the linear mapping. I
> hope
> this is independent of both CMA and this patch.

Right, that's one more big item that is still on the TODO list.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
