From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Jan 2018 12:16:15 +0000
Subject: [PATCH 08/22] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
In-Reply-To: <20180110080932.14157-9-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-9-hch@lst.de>
Message-ID: <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 08:09, Christoph Hellwig wrote:
> To properly reject too small DMA masks based on the addressability of the
> bounce buffer.

I reckon this is self-evident enough that it should simply be squashed 
into the previous patch.

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/swiotlb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 0fae2f45c3c0..539fd1099ba9 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -1128,5 +1128,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
>   	.unmap_sg		= swiotlb_unmap_sg_attrs,
>   	.map_page		= swiotlb_map_page,
>   	.unmap_page		= swiotlb_unmap_page,
> +	.dma_supported		= swiotlb_dma_supported,
>   };
>   #endif /* CONFIG_DMA_DIRECT_OPS */
> 
