From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 13 Nov 2016 11:42:34 +0000
Subject: [PATCH v3 2/2] arm64: Wire up iommu_dma_{map, unmap}_resource()
In-Reply-To: <706f6bc883775206d661f38d9c1cbaa4cc4d04b7.1478887214.git.robin.murphy@arm.com>
References: <7d54803d32968be46a1a525d7160feb13af72f00.1478887214.git.robin.murphy@arm.com>
 <706f6bc883775206d661f38d9c1cbaa4cc4d04b7.1478887214.git.robin.murphy@arm.com>
Message-ID: <20161113114234.GB24837@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 06:27:35PM +0000, Robin Murphy wrote:
> With no coherency to worry about, just plug'em straight in.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3f74d0d98de6..5cd0a383b14b 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -796,6 +796,8 @@ static struct dma_map_ops iommu_dma_ops = {
>  	.sync_single_for_device = __iommu_sync_single_for_device,
>  	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
>  	.sync_sg_for_device = __iommu_sync_sg_for_device,
> +	.map_resource = iommu_dma_map_resource,
> +	.unmap_resource = iommu_dma_unmap_resource,
>  	.dma_supported = iommu_dma_supported,
>  	.mapping_error = iommu_dma_mapping_error,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I guess these two patches would go in via the iommu tree.

-- 
Catalin
