From: dk@syse.no (Daniel K.)
Date: Sun, 08 Nov 2015 21:39:29 +0000
Subject: [PATCH] dma: fix returnvar.cocci warnings
In-Reply-To: <alpine.DEB.2.10.1511080843100.2637@hadrien>
References: <alpine.DEB.2.10.1511080843100.2637@hadrien>
Message-ID: <563FC111.4060308@syse.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2015 07:45 AM, Julia Lawall wrote:
>  Remove unneeded variable used to store return value.
> 
> --- a/drivers/dma/qcom/hidma_ll.c
> +++ b/drivers/dma/qcom/hidma_ll.c
> @@ -567,14 +567,13 @@ int hidma_ll_resume(struct hidma_lldev *
> 
>  static int hidma_ll_hw_start(struct hidma_lldev *lldev)
>  {
> -	int rc = 0;
>  	unsigned long irqflags;
> 
>  	spin_lock_irqsave(&lldev->lock, irqflags);
>  	writel(lldev->tre_write_offset, lldev->trca + TRCA_DOORBELL_OFFSET);
>  	spin_unlock_irqrestore(&lldev->lock, irqflags);
> 
> -	return rc;
> +	return 0;
>  }
> 
>  bool hidma_ll_isenabled(struct hidma_lldev *lldev)

Seems rather pointless, what about 'static void ...' and dropping the
return statement?


Daniel K.
