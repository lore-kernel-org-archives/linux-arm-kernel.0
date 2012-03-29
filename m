From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 29 Mar 2012 15:51:36 +0200 (CEST)
Subject: [PATCHv2 02/14] X86 & IA64: adapt for dma_map_ops changes
In-Reply-To: <1332855768-32583-3-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <alpine.LFD.2.02.1203291545520.2542@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Mar 2012, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> -static inline void *dma_alloc_coherent(struct device *dev, size_t size,
> -				       dma_addr_t *daddr, gfp_t gfp)
> +#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)

Please make this an inline function.

>  
> +#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)

Inline please.

> -static inline void dma_free_coherent(struct device *dev, size_t size,
> -				     void *vaddr, dma_addr_t bus)
> +#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)

Ditto

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
