From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Jan 2016 17:56:21 +0530
Subject: [PATCH V2 3/8] dmaengine: bcm2835: use shared interrupt for
 channel 11 to 14.
In-Reply-To: <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160113122621.GA11130@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 05:33:01PM +0000, kernel at martin.sperl.org wrote:
> @@ -638,13 +666,21 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  		goto err_no_dma;
>  	}
>  
> -	for (i = 0; i < pdev->num_resources; i++) {
> -		irq = platform_get_irq(pdev, i);
> +	for (i = 0; i <= BCM2835_DMA_MAX_CHANNEL_NUMBER; i++) {
> +		if (BCM2835_DMA_IRQ_SHARED_MASK & BIT(i)) {

Ideally this should be done thru DT data and not hard coded in kernel. I
dont think this assumption will hold good for next gen of this device, so
better to get this from DT!

-- 
~Vinod
