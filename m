From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 22 Nov 2011 09:53:56 +0530
Subject: [PATCH] IMX/DMA : set the DMA direction in the sdma_control()
In-Reply-To: <1321605482-6616-1-git-send-email-b32955@freescale.com>
References: <1321605482-6616-1-git-send-email-b32955@freescale.com>
Message-ID: <1321935836.1516.220.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-11-18 at 16:38 +0800, Huang Shijie wrote:
> Set the right DMA direction in the sdma_control(), else
> we will get the wrong log when enable the DYNAMIC_DEBUG.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/dma/imx-sdma.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f993955..37b8f84 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1102,6 +1102,7 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  			sdmac->watermark_level = dmaengine_cfg->dst_maxburst;
>  			sdmac->word_size = dmaengine_cfg->dst_addr_width;
>  		}
> +		sdmac->direction = dmaengine_cfg->direction;
>  		return sdma_config_channel(sdmac);
>  	default:
>  		return -ENOSYS;
Applied thanks

-- 
~Vinod
