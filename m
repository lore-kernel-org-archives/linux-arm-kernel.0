From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 21 Apr 2016 17:20:07 +0200
Subject: [PATCH] dmaengine: bcm2835: fix typo in legacy-mode warning
 message
In-Reply-To: <1461230641-20317-1-git-send-email-kernel@martin.sperl.org>
References: <1461230641-20317-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <5718EFA7.30504@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am 21.04.2016 um 11:24 schrieb kernel at martin.sperl.org:
> From: Martin Sperl <kernel@martin.sperl.org>
>
> Fix typo in warning message that there is no "interrupt-names"
> property defined in the device-tree and legacy-mode is used.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/dma/bcm2835-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 9740151..d724393 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -974,7 +974,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  
>  		/* legacy device tree case handling */
>  		dev_warn_once(&pdev->dev,
> -			      "missing interrupts-names property in device tree - legacy interpretation is used");
> +			      "missing interrupt-names property in device tree - legacy interpretation is used");

does it also misses a newline at the end?

>  		/*
>  		 * in case of channel >= 11
>  		 * use the 11th interrupt and that is shared
