From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 May 2014 22:03:54 +0200
Subject: [PATCH v3 1/2] dmaengine: s3c24xx-dma: Process whole SG chain
In-Reply-To: <1400617382-7051-1-git-send-email-anarsoul@gmail.com>
References: <1400617382-7051-1-git-send-email-anarsoul@gmail.com>
Message-ID: <2226052.jOkjSV51zk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 20. Mai 2014, 23:23:01 schrieb Vasily Khoruzhick:
> Due to redundant 'break' in loop driver processed only first chunk.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

I think I wrote this for v1 already, but here it is again.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> v2: No changes
> v3: No changes
> 
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
