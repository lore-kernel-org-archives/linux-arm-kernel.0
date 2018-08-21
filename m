From: vkoul@kernel.org (Vinod)
Date: Tue, 21 Aug 2018 21:20:24 +0530
Subject: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel
 validation
In-Reply-To: <1532688639-32230-3-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20180821155024.GH2388@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> In axidma start_transfer, prefer checking channel states before
> other params i.e pending_list.

and what that preference be?

> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 06d1632..a37871e 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (chan->err)
>  		return;
>  
> -	if (list_empty(&chan->pending_list))
> +	if (!chan->idle)
>  		return;
>  
> -	if (!chan->idle)
> +	if (list_empty(&chan->pending_list))
>  		return;
>  
>  	head_desc = list_first_entry(&chan->pending_list,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
