From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Jan 2014 16:10:54 +0100
Subject: [PATCH] usb: at91-udc: fix irq and iomem resource retrieval
In-Reply-To: <1390488102-8548-1-git-send-email-jjhiblot@traphandler.com>
References: <1390488102-8548-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52E130FE.1070506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/2014 15:41, Jean-Jacques Hiblot :
> When using dt resources retrieval (interrupts and reg properties) there is
> no predefined order for these resources in the platform dev resource
> table. Also don't expect the number of resource to be always 2.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Yes, indeed.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Maybe we can also add a "stable" tag to it. Looking at the history of
this file, I think that we can add a pretty old stable limit... But as
it only makes sense with DT, I would advice something like this, for the
3.4-ish timeframe:

Cc: stable <stable@vger.kernel.org> # 3.4

Bye,

> ---
>  drivers/usb/gadget/at91_udc.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> index 4cc4fd6..dfd2943 100644
> --- a/drivers/usb/gadget/at91_udc.c
> +++ b/drivers/usb/gadget/at91_udc.c
> @@ -1710,16 +1710,6 @@ static int at91udc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	if (pdev->num_resources != 2) {
> -		DBG("invalid num_resources\n");
> -		return -ENODEV;
> -	}
> -	if ((pdev->resource[0].flags != IORESOURCE_MEM)
> -			|| (pdev->resource[1].flags != IORESOURCE_IRQ)) {
> -		DBG("invalid resource type\n");
> -		return -ENODEV;
> -	}
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
>  		return -ENXIO;
> 


-- 
Nicolas Ferre
