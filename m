From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 11 Feb 2016 11:00:47 +0200
Subject: [PATCH] dmaengine: omap-dma: Implement device_synchronize callback
In-Reply-To: <1455180894-2672-1-git-send-email-peter.ujfalusi@ti.com>
References: <1455180894-2672-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <56BC4DBF.8080605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2016 10:54 AM, Peter Ujfalusi wrote:
> We need the callback to support the dmaengine_terminate_sync().

I have made some typos and I only compiled the kernel after sending the patch..
Resending.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/omap-dma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index e691f48f9d73..7c6a300b6b57 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -1007,6 +1007,13 @@ static int omap_dma_terminate_all(struct dma_chan *chan)
>  	return 0;
>  }
>  
> +static void omap_dma_synchronize(struct dma_chan *c)
> +{
> +	struct omap_chan *c = to_omap_dma_chan(chan);
> +
> +	vchan_synchronize(&c->vc);
> +}
> +
>  static int omap_dma_pause(struct dma_chan *chan)
>  {
>  	struct omap_chan *c = to_omap_dma_chan(chan);
> @@ -1110,6 +1117,7 @@ static int omap_dma_probe(struct platform_device *pdev)
>  	od->ddev.device_pause = omap_dma_pause;
>  	od->ddev.device_resume = omap_dma_resume;
>  	od->ddev.device_terminate_all = omap_dma_terminate_all;
> +	od-ddev.device_synchronize = omap_dma_synchronize;
>  	od->ddev.src_addr_widths = OMAP_DMA_BUSWIDTHS;
>  	od->ddev.dst_addr_widths = OMAP_DMA_BUSWIDTHS;
>  	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> 


-- 
P?ter
