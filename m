From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 12 Mar 2012 21:59:56 +0530
Subject: [PATCH v3 1/2] dmaengine: Add support for per xfer specific
 privatedata
In-Reply-To: <1331548336-27802-1-git-send-email-kumarrav@codeaurora.org>
References: <1331548336-27802-1-git-send-email-kumarrav@codeaurora.org>
Message-ID: <1331569796.1727.9.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-03-12 at 16:02 +0530, Ravi Kumar V wrote:
> Add new argument to DMA SG and Interleave mode for passing
> per transfer specific private data, using this it enables the
> dma devices which needs to pass the parameters which changes per
> each transfer.
> 
> Signed-off-by: Ravi Kumar V <kumarrav@codeaurora.org>
> ---
>  include/linux/dmaengine.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 679b349..b8f0495 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -570,7 +570,7 @@ struct dma_device {
>  		struct dma_chan *chan,
>  		struct scatterlist *dst_sg, unsigned int dst_nents,
>  		struct scatterlist *src_sg, unsigned int src_nents,
> -		unsigned long flags);
> +		unsigned long flags, void *context);
Please follow the related discussion we had. Alexandre had already
posted updated and this needs to follow.
Also this way you break the existing drivers which use this API, not
sure why you posted without fixing them?

>  	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
>  		struct dma_chan *chan, struct scatterlist *sgl,
> @@ -581,7 +581,7 @@ struct dma_device {
>  		size_t period_len, enum dma_transfer_direction direction);
>  	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
>  		struct dma_chan *chan, struct dma_interleaved_template *xt,
> -		unsigned long flags);
> +		unsigned long flags, void *context);
>  	int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  		unsigned long arg);
>  


-- 
~Vinod
