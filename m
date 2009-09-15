From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:56:03 +0100
Subject: [PATCH 2/7] S3C64xx DMA: 'size' argument of dma_pool_create
In-Reply-To: <1253008879-7523-1-git-send-email-jassi.brar@samsung.com>
References: <1253008879-7523-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915235603.GE13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:01:19PM +0900, Jassi wrote:
> Provide actual minimum(struct pl080s_lli) size of block
> to dma_pool_create call, instead of hardcoded 32 bytes.
> 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>

Applied to next-s3c64xx-fixes

> ---
>  arch/arm/plat-s3c64xx/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
> index 67aa93d..b26d2a2 100644
> --- a/arch/arm/plat-s3c64xx/dma.c
> +++ b/arch/arm/plat-s3c64xx/dma.c
> @@ -697,7 +697,7 @@ static int __init s3c64xx_dma_init(void)
>  
>  	printk(KERN_INFO "%s: Registering DMA channels\n", __func__);
>  
> -	dma_pool = dma_pool_create("DMA-LLI", NULL, 32, 16, 0);
> +	dma_pool = dma_pool_create("DMA-LLI", NULL, sizeof(struct pl080s_lli), 16, 0);
>  	if (!dma_pool) {
>  		printk(KERN_ERR "%s: failed to create pool\n", __func__);
>  		return -ENOMEM;
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
