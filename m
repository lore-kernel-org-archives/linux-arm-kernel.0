From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Thu, 13 Mar 2014 13:03:14 +0000
Subject: [PATCH 13/18] dma: edma: Print the direction value as well when
 it is not supported
In-Reply-To: <1394702320-21743-14-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <1394702320-21743-14-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1394715793.28803.240.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-03-13 at 11:18 +0200, Peter Ujfalusi wrote:
> In case of not supported direction it is better to print the direction also.
> It is unlikely, but in such an event it helps with the debugging.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/edma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 47abaac7eb18..69dd4e3de67e 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -426,7 +426,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>  		dev_width = echan->cfg.dst_addr_width;
>  		burst = echan->cfg.dst_maxburst;
>  	} else {
> -		dev_err(dev, "%s: bad direction?\n", __func__);
> +		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);

Is it possible to have direction less than zero? Maybe %u?

>  		return NULL;
>  	}
>  
> @@ -519,7 +519,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>  		dev_width = echan->cfg.dst_addr_width;
>  		burst = echan->cfg.dst_maxburst;
>  	} else {
> -		dev_err(dev, "%s: bad direction?\n", __func__);
> +		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);

Ditto.

>  		return NULL;
>  	}
>  


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
