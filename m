From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 11 Feb 2016 02:03:40 +0200
Subject: [PATCH v3 2/8] dma-mapping: add {map,
 unmap}_resource to dma_map_ops
In-Reply-To: <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1751306.gvBkWbovht@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 February 2016 01:57:52 Niklas S?derlund wrote:
> Add methods to handle mapping of device resources from a physical
> address. This is needed for example to map be able to map MMIO FIFO
> registers to a IOMMU.
> 
> Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Apart from the typo in the commit message that Sergei already pointed out,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/dma-mapping.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 75857cd..e3aba4e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -49,6 +49,12 @@ struct dma_map_ops {
>  			 struct scatterlist *sg, int nents,
>  			 enum dma_data_direction dir,
>  			 struct dma_attrs *attrs);
> +	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_addr,
> +			       size_t size, enum dma_data_direction dir,
> +			       struct dma_attrs *attrs);
> +	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
> +			   size_t size, enum dma_data_direction dir,
> +			   struct dma_attrs *attrs);
>  	void (*sync_single_for_cpu)(struct device *dev,
>  				    dma_addr_t dma_handle, size_t size,
>  				    enum dma_data_direction dir);

-- 
Regards,

Laurent Pinchart
