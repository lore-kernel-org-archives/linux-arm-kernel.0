From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 19 May 2014 00:50:43 +0200
Subject: [PATCH 1/2] dmaengine: s3c24xx-dma: Process whole SG chain
In-Reply-To: <1400445779-17365-1-git-send-email-anarsoul@gmail.com>
References: <1400445779-17365-1-git-send-email-anarsoul@gmail.com>
Message-ID: <7709063.rGYXWZ9fzc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 18. Mai 2014, 23:42:58 schrieb Vasily Khoruzhick:
> Due to redundant 'break' in a loop the driver processed only the first
> chunk.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Looks like a forgotten remnant of the time when the driver only supported sg-
lists with one element, thanks for catching this.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/dma/s3c24xx-dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
> index 4eddedb..2167608 100644
> --- a/drivers/dma/s3c24xx-dma.c
> +++ b/drivers/dma/s3c24xx-dma.c
> @@ -961,7 +961,6 @@ static struct dma_async_tx_descriptor
> *s3c24xx_dma_prep_slave_sg( dsg->src_addr = slave_addr;
>  			dsg->dst_addr = sg_dma_address(sg);
>  		}
> -		break;
>  	}
> 
>  	return vchan_tx_prep(&s3cchan->vc, &txd->vd, flags);
