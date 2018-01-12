From: konrad@darnok.org (Konrad Rzeszutek Wilk)
Date: Fri, 12 Jan 2018 08:16:48 -0500
Subject: [PATCH 19/33] dma-mapping: warn when there is no coherent_dma_mask
In-Reply-To: <20180110080027.13879-20-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-20-hch@lst.de>
Message-ID: <20180112131646.GA26900@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 09:00:13AM +0100, Christoph Hellwig wrote:
> These days all devices should have a DMA coherent mask, and most dma_ops
> implementations rely on that fact.  But just to be sure add an assert to
> ring the warning bell if that is not the case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  include/linux/dma-mapping.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d84951865be7..9f28b2fa329e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -513,6 +513,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  	void *cpu_addr;
>  
>  	BUG_ON(!ops);
> +	WARN_ON_ONCE(!dev->coherent_dma_mask);
>  
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
> -- 
> 2.14.2
> 
