From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jun 2013 08:40:00 +0530
Subject: [PATCH] dmaengine: ste_dma40: Declare memcpy config as static
In-Reply-To: <1371719859-4600-1-git-send-email-fabio.baltieri@linaro.org>
References: <1371719859-4600-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130621031000.GB23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 11:17:39AM +0200, Fabio Baltieri wrote:
> Fix sparse warnings:
> 
> drivers/dma/ste_dma40.c:81:26: warning: symbol 'dma40_memcpy_conf_phy' was not declared. Should it be static?
> drivers/dma/ste_dma40.c:95:26: warning: symbol 'dma40_memcpy_conf_log' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>

I guess this would be dependent on recent ste_dma40 patches so best way is
Linus's tree, right?

--
~Vinod
> ---
> 
> Hi Linus,
> 
> just a quick sparse error fixup on the dma driver.
> 
> Thanks,
> Fabio
> 
>  drivers/dma/ste_dma40.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index fa4f9a3..8f72085 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -78,7 +78,7 @@ static int dma40_memcpy_channels[] = {
>  };
>  
>  /* Default configuration for physcial memcpy */
> -struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
> +static struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
>  	.mode = STEDMA40_MODE_PHYSICAL,
>  	.dir = DMA_MEM_TO_MEM,
>  
> @@ -92,7 +92,7 @@ struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
>  };
>  
>  /* Default configuration for logical memcpy */
> -struct stedma40_chan_cfg dma40_memcpy_conf_log = {
> +static struct stedma40_chan_cfg dma40_memcpy_conf_log = {
>  	.mode = STEDMA40_MODE_LOGICAL,
>  	.dir = DMA_MEM_TO_MEM,
>  
> -- 
> 1.8.2
> 

-- 
