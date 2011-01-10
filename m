From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Jan 2011 14:21:20 +0100
Subject: [PATCH] dmaengine: at_hdmac: use dma_address to program DMA
	hardware
In-Reply-To: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
References: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4D2B07D0.5050602@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 15/12/2010 18:50, Nicolas Ferre :
> In atc_prep_slave_sg() function we use dma_address field of scatterlist with
> sg_dma_address() macro instead of sg_phys(). DMA address is already computed
> by dma_map_sg() or another mapping function in calling driver.

Ping?

> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/dma/at_hdmac.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index ea0ee81..ee7dacd 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -670,7 +670,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  			if (!desc)
>  				goto err_desc_get;
>  
> -			mem = sg_phys(sg);
> +			mem = sg_dma_address(sg);
>  			len = sg_dma_len(sg);
>  			mem_width = 2;
>  			if (unlikely(mem & 3 || len & 3))
> @@ -712,7 +712,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  			if (!desc)
>  				goto err_desc_get;
>  
> -			mem = sg_phys(sg);
> +			mem = sg_dma_address(sg);
>  			len = sg_dma_len(sg);
>  			mem_width = 2;
>  			if (unlikely(mem & 3 || len & 3))


-- 
Nicolas Ferre
