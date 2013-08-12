From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 12 Aug 2013 12:47:14 +0530
Subject: [PATCH v3 03/12] dma: edma: remove limits on number of slots
In-Reply-To: <1375719297-12871-4-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
 <1375719297-12871-4-git-send-email-joelf@ti.com>
Message-ID: <52088BFA.8090004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013 09:44 PM, Joel Fernandes wrote:
> With this series, this check is no longer required and
> we shouldn't need to reject drivers DMA'ing more than the
> MAX number of slots.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  drivers/dma/edma.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 7b0853c..b6d609c 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -247,12 +247,6 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>  		return NULL;
>  	}
>  
> -	if (sg_len > MAX_NR_SG) {
> -		dev_err(dev, "Exceeded max SG segments %d > %d\n",
> -			sg_len, MAX_NR_SG);
> -		return NULL;
> -	}

This patch comes too early. Should be moved to the end of the series
when the support you rely on is actually present.

Thanks,
Sekhar
