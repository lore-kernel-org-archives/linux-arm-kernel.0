From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 5 Oct 2015 16:37:47 +0100
Subject: [PATCH v5 06/10] dmaengine: add API for getting dma controller's
 quirk
In-Reply-To: <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 07:48:59AM +0800, Shawn Lin wrote:
> Add dmaengine_get_quirks API for peripheral devices to query
> quirks if they need it to make special workaround due to broken
> dma controller design.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None
> 
>  include/linux/dmaengine.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index e2f5eb4..5174ca4 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -704,6 +704,7 @@ struct dma_device {
>  
>  	int (*device_config)(struct dma_chan *chan,
>  			     struct dma_slave_config *config);
> +	int (*device_get_quirks)(struct dma_chan *chan);

And why do we want to expose this to users? THis doesnt seem right!

A quirk may exists but should be handled inside the controller driver and do
appropriate action. You don't tell users or expect them to handle these

-- 
~Vinod
