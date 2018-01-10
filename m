From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Jan 2018 12:13:39 +0000
Subject: [PATCH 02/22] arm64: rename swiotlb_dma_ops
In-Reply-To: <20180110080932.14157-3-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-3-hch@lst.de>
Message-ID: <4564e50d-7e52-7b72-7c95-d4acda92da0c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 08:09, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index f3a637b98487..6840426bbe77 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -368,7 +368,7 @@ static int __swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t addr)
>   	return 0;
>   }
>   
> -static const struct dma_map_ops swiotlb_dma_ops = {
> +static const struct dma_map_ops arm64_swiotlb_dma_ops = {
>   	.alloc = __dma_alloc,
>   	.free = __dma_free,
>   	.mmap = __swiotlb_mmap,
> @@ -923,7 +923,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   			const struct iommu_ops *iommu, bool coherent)
>   {
>   	if (!dev->dma_ops)
> -		dev->dma_ops = &swiotlb_dma_ops;
> +		dev->dma_ops = &arm64_swiotlb_dma_ops;
>   
>   	dev->archdata.dma_coherent = coherent;
>   	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
> 
