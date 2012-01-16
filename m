From: david@gibson.dropbear.id.au (David Gibson)
Date: Mon, 16 Jan 2012 12:57:10 +1100
Subject: [PATCH 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
In-Reply-To: <1324643253-3024-2-git-send-email-m.szyprowski@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <1324643253-3024-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120116015710.GD4512@truffala.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 01:27:20PM +0100, Marek Szyprowski wrote:
> Introduce new generic alloc and free methods with attributes argument.
> 
> Existing alloc_coherent and free_coherent can be implemented on top of the
> new calls with NULL attributes argument. Later also dma_alloc_non_coherent
> can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
> dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.
> 
> This way the drivers will get more generic, platform independent way of
> allocating dma buffers with specific parameters.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks sensible to me.

Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
