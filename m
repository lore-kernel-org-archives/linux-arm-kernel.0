From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Fri, 29 Jan 2010 12:22:32 -0800
Subject: [patch 1/1] arm: bcmring: Fix locking in dma_unmap
In-Reply-To: <20100129112739.265153293@linutronix.de>
References: <20100129112730.919289325@linutronix.de>
	<20100129112739.265153293@linutronix.de>
Message-ID: <20100129202232.GI8104@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Thomas for fixing this bug.

Acked-by: Leo Chen <leochen@broadcom.com>

On Fri, Jan 29, 2010 at 03:28:45AM -0800, Thomas Gleixner wrote:
> dma_unmap is missing a down(&memMap->lock).
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Leo Chen <leochen@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-bcmring/dma.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6-tip/arch/arm/mach-bcmring/dma.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-bcmring/dma.c
> +++ linux-2.6-tip/arch/arm/mach-bcmring/dma.c
> @@ -2225,6 +2225,8 @@ int dma_unmap(DMA_MemMap_t *memMap,	/* S
>  	DMA_Region_t *region;
>  	DMA_Segment_t *segment;
>  
> +	down(&memMap->lock);
> +
>  	for (regionIdx = 0; regionIdx < memMap->numRegionsUsed; regionIdx++) {
>  		region = &memMap->region[regionIdx];
>  
> 
> 
> 

-- 

Leo Hao Chen

------------------------
Life is short, run long.
