From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Aug 2018 22:50:47 -0700
Subject: [RFC 2/3] USB: core: Add non-coherent buffer allocation helpers
In-Reply-To: <4fc5107f93871599ead017af7ad50f22535a7683.camel@collabora.com>
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-3-ezequiel@collabora.com>
 <20180830175850.GA11521@infradead.org>
 <4fc5107f93871599ead017af7ad50f22535a7683.camel@collabora.com>
Message-ID: <20180831055047.GA9140@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 07:11:35PM -0300, Ezequiel Garcia wrote:
> On Thu, 2018-08-30 at 10:58 -0700, Christoph Hellwig wrote:
> > Please don't introduce new DMA_ATTR_NON_CONSISTENT users, it is
> > a rather horrible interface, and I plan to kill it off rather sooner
> > than later.  I plan to post some patches for a better interface
> > that can reuse the normal dma_sync_single_* interfaces for ownership
> > transfers.  I can happily include usb in that initial patch set based
> > on your work here if that helps.
> 
> Please do. Until we have proper allocators that go thru the DMA API,
> drivers will have to kmalloc the USB transfer buffers, and have
> streaming mappings. Which in turns mean not using IOMMU or CMA.

dma_map_page will of course use the iommu.
