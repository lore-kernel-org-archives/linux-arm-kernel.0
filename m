From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2018 11:16:04 +0200
Subject: [PATCH RESEND] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
In-Reply-To: <20181015105517.28032-1-wsa+renesas@sang-engineering.com>
References: <20181015105517.28032-1-wsa+renesas@sang-engineering.com>
Message-ID: <20181017091604.63mfy5ztgpbijycm@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 12:55:17PM +0200, Wolfram Sang wrote:
> Update the comment because we don't set the pointer to NULL anymore.
> Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
> 
> Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 66566472c153..e3b04786838f 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2287,7 +2287,7 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
>   * @dev: valid struct device pointer
>   *
>   * Detaches the provided device from a previously attached map.
> - * This voids the dma operations (dma_map_ops pointer)
> + * This overwrites the dma_ops pointer with appropriate non-IOMMU ops.
>   */
>  void arm_iommu_detach_device(struct device *dev)
>  {
> -- 
> 2.11.0
> 
