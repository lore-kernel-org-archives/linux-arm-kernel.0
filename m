From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Jan 2018 11:07:55 +0000
Subject: [PATCH 09/33] dma-mapping: take dma_pfn_offset into account in
 dma_max_pfn
In-Reply-To: <20180110080027.13879-10-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-10-hch@lst.de>
Message-ID: <6e4732eb-9eaf-7e5b-863c-d3faa47bb513@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 08:00, Christoph Hellwig wrote:
> This makes sure the generic version can be used with architectures /
> devices that have a DMA offset in the direct mapping.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 81ed9b2d84dc..d84951865be7 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   #ifndef dma_max_pfn
>   static inline unsigned long dma_max_pfn(struct device *dev)
>   {
> -	return *dev->dma_mask >> PAGE_SHIFT;
> +	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
>   }
>   #endif
>   
> 
