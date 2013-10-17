From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 17 Oct 2013 16:43:31 +0300
Subject: [PATCH 08/28] dmaengine: dw: use DMA_COMPLETE for dma
 completion status
In-Reply-To: <1381940926-25564-9-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
 <1381940926-25564-9-git-send-email-vinod.koul@intel.com>
Message-ID: <1382017411.29062.142.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-16 at 21:58 +0530, Vinod Koul wrote:
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/dma/dw/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 89eb89f..2c29331 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1098,13 +1098,13 @@ dwc_tx_status(struct dma_chan *chan,
>  	enum dma_status		ret;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
> -	if (ret == DMA_SUCCESS)
> +	if (ret == DMA_COMPLETE)
>  		return ret;
>  
>  	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
> -	if (ret != DMA_SUCCESS)
> +	if (ret != DMA_COMPLETE)
>  		dma_set_residue(txstate, dwc_get_residue(dwc));
>  
>  	if (dwc->paused && ret == DMA_IN_PROGRESS)

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
