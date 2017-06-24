From: hch@lst.de (Christoph Hellwig)
Date: Sat, 24 Jun 2017 09:18:55 +0200
Subject: clean up and modularize arch dma_mapping interface V2
In-Reply-To: <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
References: <20170616181059.19206-1-hch@lst.de>
 <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
Message-ID: <20170624071855.GD14580@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 12:24:28PM -0700, tndave wrote:
> Thanks for doing this.
> So archs can still have their own definition for dma_set_mask() if 
> HAVE_ARCH_DMA_SET_MASK is y?
> (and similarly for dma_set_coherent_mask() when 
> CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK is y)
> Any plan to change these?

Yes, those should go away, but I'm not entirely sure how yet.  We'll
need some hook for switching between an IOMMU and a direct mapping
(I guess that's what you want to do for sparc as well?), and I need
to find the best way to do that.  Reimplementing all of dma_set_mask
and dma_set_coherent_mask is something that I want to move away from.
