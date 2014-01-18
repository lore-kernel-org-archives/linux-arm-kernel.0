From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 18 Jan 2014 06:20:59 +0100
Subject: [PATCH 1/2] USB: at91: fix the number of endpoint parameter
In-Reply-To: <1389927565-22477-1-git-send-email-voice.shen@atmel.com>
References: <1389927565-22477-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20140118052059.GL9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:59 Fri 17 Jan     , Bo Shen wrote:
> In sama5d3 SoC, there are 16 endpoints. As the USBA_NR_ENDPOINTS
> is only 7. So, fix it for sama5d3 SoC using the udc->num_ep.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
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

no the limit need to specified in the driver as a checkpoint by the compatible
or platform driver id

Best Regards,
J.
>  			if (ep_status & (1 << i)) {
>  				if (ep_is_control(&udc->usba_ep[i]))
>  					usba_control_irq(udc, &udc->usba_ep[i]);
> -- 
> 1.8.5.2
> 
