From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Feb 2014 09:43:20 +0100
Subject: [PATCH v2 1/2] USB: at91: fix the number of endpoint parameter
In-Reply-To: <1392775664-16404-1-git-send-email-voice.shen@atmel.com>
References: <1392775664-16404-1-git-send-email-voice.shen@atmel.com>
Message-ID: <53046EA8.9090302@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/2014 03:07, Bo Shen :
> In sama5d3 SoC, there are 16 endpoints, which is different with
> earlier SoCs (only have 7 endpoints). The USBA_NR_ENDPOINTS micro

you should read "macro".

> is not suitable for sama5d3. So, get the endpoints number through
> the udc->num_ep, which get from platform data for non-dt kernel,
> or parse from dt node.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> Changes in v2:
>   - Make the commit message more clearer.
> 
>  drivers/usb/gadget/atmel_usba_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 2cb52e0..7e67a81 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1670,7 +1670,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
>  	if (ep_status) {
>  		int i;
>  
> -		for (i = 0; i < USBA_NR_ENDPOINTS; i++)
> +		for (i = 0; i < udc->num_ep; i++)
>  			if (ep_status & (1 << i)) {
>  				if (ep_is_control(&udc->usba_ep[i]))
>  					usba_control_irq(udc, &udc->usba_ep[i]);
> 


-- 
Nicolas Ferre
