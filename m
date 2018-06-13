From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 Jun 2018 11:53:19 +0200
Subject: [PATCH v3 4/6] dmaengine: imx-sdma: remove usless lock
In-Reply-To: <1528729173-28684-5-git-send-email-yibin.gong@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
 <1528729173-28684-5-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180613095319.r6aenntgvne57i57@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2018 at 10:59:31PM +0800, Robin Gong wrote:
> No need anymore for 'lock' now since virtual dma will provide
> the common lock instead.

This can be merged into the last patch, maybe rephrasing the commit
message from "revert..." to what is being done. To me "revert" sounds
like the commit was wrong, but it wasn't at that time.

Sascha

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index e0af8ee..f150b38 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -349,7 +349,6 @@ struct sdma_channel {
>  	unsigned long			event_mask[2];
>  	unsigned long			watermark_level;
>  	u32				shp_addr, per_addr;
> -	spinlock_t			lock;
>  	enum dma_status			status;
>  	struct imx_dma_data		data;
>  };
> @@ -1907,7 +1906,6 @@ static int sdma_probe(struct platform_device *pdev)
>  		struct sdma_channel *sdmac = &sdma->channel[i];
>  
>  		sdmac->sdma = sdma;
> -		spin_lock_init(&sdmac->lock);
>  
>  		sdmac->channel = i;
>  		sdmac->vc.desc_free = sdma_desc_free;
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
