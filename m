From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Jun 2011 15:22:05 +0200
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
	method to more generic alloc/free_attrs
In-Reply-To: <000701cc34c5$0c50b800$24f22800$%szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<201106241751.35655.arnd@arndb.de>
	<000701cc34c5$0c50b800$24f22800$%szyprowski@samsung.com>
Message-ID: <201106271522.05486.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 June 2011, Marek Szyprowski wrote:
> > On a related note, do you plan to make the CMA work use this
> > transparently, or do you want to have a DMA_ATTR_LARGE or
> > DMA_ATTR_CONTIGUOUS for CMA?
> 
> IMHO it will be better to hide the CMA from the drivers. Memory allocated
> from CMA doesn't really differ from the one allocated by dma_alloc_coherent()
> (which internally use alloc_pages()), so I really see no reason for adding
> additional attribute for it.

Ok, fair enough. On a semi-related topic, IIRC we still need to make sure
that dma_alloc_coherent() pages are unmapped from the linear mapping. I hope
this is independent of both CMA and this patch.

	Arnd
