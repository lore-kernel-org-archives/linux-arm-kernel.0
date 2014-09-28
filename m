From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 28 Sep 2014 21:37:57 +0530
Subject: [PATCH 2/9] dmaengine: Make channel allocation callbacks optional
In-Reply-To: <1411808085-27792-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411808085-27792-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140928160757.GJ1638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 10:54:38AM +0200, Maxime Ripard wrote:
> Nowadays, some drivers don't have anything in there channel allocation
> callbacks anymore.
> 
> Remove the BUG_ON if those callbacks aren't implemented, in order to allow
> drivers to not implement them.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/dma/dmaengine.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index d5d30ed863ce..cfcb181b1184 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -817,8 +817,6 @@ int dma_async_device_register(struct dma_device *device)
>  	BUG_ON(dma_has_cap(DMA_INTERLEAVE, device->cap_mask) &&
>  		!device->device_prep_interleaved_dma);
>  
> -	BUG_ON(!device->device_alloc_chan_resources);
> -	BUG_ON(!device->device_free_chan_resources);
Dont think we have drivers without free. IIRC cppi one might be only
instance

-- 
~Vinod
>  	BUG_ON(!device->device_tx_status);
>  	BUG_ON(!device->device_issue_pending);
>  	BUG_ON(!device->dev);
> -- 
> 2.1.0
> 

-- 
