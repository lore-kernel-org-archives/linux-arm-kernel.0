From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 May 2016 14:27:14 +0200
Subject: [PATCH 1/3] dmaengine: at_xdmac: align descriptors on 64 bits
In-Reply-To: <1463064854-6719-1-git-send-email-ludovic.desroches@atmel.com>
References: <1463064854-6719-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <5735C822.7000503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/05/2016 16:54, Ludovic Desroches a ?crit :
> Having descriptors aligned on 64 bits allows update CNDA and CUBC in an
> atomic way.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel
> eXtended DMA Controller driver")
> Cc: stable at vger.kernel.org #v4.1 and later

Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/dma/at_xdmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 8e304b1..ba9b0b7 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -242,7 +242,7 @@ struct at_xdmac_lld {
>  	u32		mbr_dus;	/* Destination Microblock Stride Register */
>  };
>  
> -
> +/* 64-bit alignment needed to update CNDA and CUBC registers in an atomic way. */
>  struct at_xdmac_desc {
>  	struct at_xdmac_lld		lld;
>  	enum dma_transfer_direction	direction;
> @@ -253,7 +253,7 @@ struct at_xdmac_desc {
>  	unsigned int			xfer_size;
>  	struct list_head		descs_list;
>  	struct list_head		xfer_node;
> -};
> +} __aligned(sizeof(u64));
>  
>  static inline void __iomem *at_xdmac_chan_reg_base(struct at_xdmac *atxdmac, unsigned int chan_nb)
>  {
> 


-- 
Nicolas Ferre
