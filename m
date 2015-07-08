From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 8 Jul 2015 10:20:26 +0200
Subject: [PATCH 5/5] usb: gadget: atmel_usba_udc: add missing ret value
 check
In-Reply-To: <1436277773-14274-6-git-send-email-r.baldyga@samsung.com>
References: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
 <1436277773-14274-6-git-send-email-r.baldyga@samsung.com>
Message-ID: <559CDD4A.2000609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/07/2015 16:02, Robert Baldyga a ?crit :
> Add missing return value check. In case of error print debug message
> and return error code.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

Yes, it's indeed missing:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 4095cce0..37d414e 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1989,6 +1989,10 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  		ep->can_isoc = of_property_read_bool(pp, "atmel,can-isoc");
>  
>  		ret = of_property_read_string(pp, "name", &name);
> +		if (ret) {
> +			dev_err(&pdev->dev, "of_probe: name error(%d)\n", ret);
> +			goto err;
> +		}
>  		ep->ep.name = name;
>  
>  		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
> 


-- 
Nicolas Ferre
