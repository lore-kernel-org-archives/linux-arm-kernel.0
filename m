From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Oct 2018 18:04:56 +0100
Subject: [PATCH 08/10] swiotlb: don't dip into swiotlb pool for coherent
 allocations
In-Reply-To: <20181008080246.20543-9-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-9-hch@lst.de>
Message-ID: <20181012170456.GC60150@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 10:02:44AM +0200, Christoph Hellwig wrote:
> All architectures that support swiotlb also have a zone that backs up
> these less than full addressing allocations (usually ZONE_DMA32).
> 
> Because of that it is rather pointless to fall back to the global swiotlb
> buffer if the normal dma direct allocation failed - the only thing this
> will do is to eat up bounce buffers that would be more useful to serve
> streaming mappings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/mm/dma-mapping.c |   6 +--
>  include/linux/swiotlb.h     |   5 --
>  kernel/dma/swiotlb.c        | 105 +-----------------------------------
>  3 files changed, 5 insertions(+), 111 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
