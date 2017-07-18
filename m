From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Jul 2017 21:49:57 +0530
Subject: [PATCH V3 1/2] dmaengine: qcom_hidma: introduce memset support
In-Reply-To: <1498789858-18583-1-git-send-email-okaya@codeaurora.org>
References: <1498789858-18583-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20170718161956.GV3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 10:30:57PM -0400, Sinan Kaya wrote:

> @@ -410,7 +410,40 @@ static int hidma_alloc_chan_resources(struct dma_chan *dmach)
>  		return NULL;
>  
>  	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
> -				     src, dest, len, flags);
> +				     src, dest, len, flags,
> +				     HIDMA_TRE_MEMCPY);
> +
> +	/* Place descriptor in prepared list */
> +	spin_lock_irqsave(&mchan->lock, irqflags);
> +	list_add_tail(&mdesc->node, &mchan->prepared);
> +	spin_unlock_irqrestore(&mchan->lock, irqflags);

This change looks suspicious, cna you clarify the need to do this?


-- 
~Vinod
