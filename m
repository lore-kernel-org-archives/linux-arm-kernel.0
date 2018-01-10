From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 16:29:45 +0100
Subject: [PATCH 20/33] dma-mapping: clear harmful GFP_* flags in common
 code
In-Reply-To: <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-21-hch@lst.de>
 <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
Message-ID: <20180110152945.GC17790@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 11:59:30AM +0000, Robin Murphy wrote:
> Just a note that if we're all happy to enshrine the "allocations are always 
> zeroed" behaviour in the API (I am too, for the record), we should remember 
> to follow up once the dust settles to update the docs and I guess just 
> #define dma_zalloc_coherent dma_alloc_coherent.

And then just remove it.  But yes, another item for the todo list..
