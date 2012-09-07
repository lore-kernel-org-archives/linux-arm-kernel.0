From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Sep 2012 15:50:47 +0200
Subject: [PATCH] usb: gadget: at91_udc: fix dt support
In-Reply-To: <1347024462-24144-1-git-send-email-fabio.porcedda@gmail.com>
References: <1347024462-24144-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <5049FBB7.1010206@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2012 03:27 PM, Fabio Porcedda :
> Don't fail the initialization check for the platform_data
> if there is avaiable an associated device tree node.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,

> ---
>  drivers/usb/gadget/at91_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> index c9e66df..4147219 100644
> --- a/drivers/usb/gadget/at91_udc.c
> +++ b/drivers/usb/gadget/at91_udc.c
> @@ -1703,7 +1703,7 @@ static int __devinit at91udc_probe(struct platform_device *pdev)
>  	int		retval;
>  	struct resource	*res;
>  
> -	if (!dev->platform_data) {
> +	if (!dev->platform_data && !pdev->dev.of_node) {
>  		/* small (so we copy it) but critical! */
>  		DBG("missing platform_data\n");
>  		return -ENODEV;
> 


-- 
Nicolas Ferre
