From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 7 Jul 2011 21:51:20 +0200
Subject: [PATCH 2/4] arm: plat-s3c24xx: dma: drop return codes in void
	function
In-Reply-To: <1310033919-4245-3-git-send-email-w.sang@pengutronix.de>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
	<1310033919-4245-3-git-send-email-w.sang@pengutronix.de>
Message-ID: <201107072151.20618.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 07, 2011, Wolfram Sang wrote:
> Commit bb072c3c (ARM / Samsung: Use struct syscore_ops for "core" power
> management) turned s3c2410_dma_resume_chan() from int to void. So, drop
> the actual return values, too. Fixes:
> 
> arch/arm/plat-s3c24xx/dma.c: In function 's3c2410_dma_resume_chan':
> arch/arm/plat-s3c24xx/dma.c:1238:3: warning: 'return' with a value, in function returning void
> arch/arm/plat-s3c24xx/dma.c:1250:2: warning: 'return' with a value, in function returning void
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-s3c24xx/dma.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
> index a5b3684..a79a8cc 100644
> --- a/arch/arm/plat-s3c24xx/dma.c
> +++ b/arch/arm/plat-s3c24xx/dma.c
> @@ -1231,7 +1231,7 @@ static void s3c2410_dma_resume_chan(struct s3c2410_dma_chan *cp)
>  	/* restore channel's hardware configuration */
>  
>  	if (!cp->in_use)
> -		return 0;
> +		return;
>  
>  	printk(KERN_INFO "dma%d: restoring configuration\n", cp->number);
>  
> @@ -1242,8 +1242,6 @@ static void s3c2410_dma_resume_chan(struct s3c2410_dma_chan *cp)
>  
>  	if (cp->map != NULL)
>  		dma_sel.select(cp, cp->map);
> -
> -	return 0;
>  }
>  
>  static void s3c2410_dma_resume(void)
> 
