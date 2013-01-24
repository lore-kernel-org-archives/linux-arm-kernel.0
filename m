From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 24 Jan 2013 19:52:52 +0100
Subject: [RFC/PATCH 32/32] usb: gadget: drop now unnecessary flag
In-Reply-To: <1359042370-4358-33-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-33-git-send-email-balbi@ti.com>
Message-ID: <2268214.yJrDJgELNj@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Thursday 24 of January 2013 17:46:10 Felipe Balbi wrote:
> We don't need the ->register_my_device flag
> anymore because all UDC drivers have been
> properly converted.
> 
> Let's remove every history of it.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/chipidea/udc.c             | 1 -
>  drivers/usb/dwc3/gadget.c              | 1 -
>  drivers/usb/gadget/amd5536udc.c        | 1 -
>  drivers/usb/gadget/at91_udc.c          | 1 -
>  drivers/usb/gadget/atmel_usba_udc.c    | 1 -
>  drivers/usb/gadget/bcm63xx_udc.c       | 1 -
>  drivers/usb/gadget/dummy_hcd.c         | 1 -
>  drivers/usb/gadget/fsl_qe_udc.c        | 1 -
>  drivers/usb/gadget/fsl_udc_core.c      | 1 -
>  drivers/usb/gadget/fusb300_udc.c       | 1 -
>  drivers/usb/gadget/goku_udc.c          | 1 -
>  drivers/usb/gadget/imx_udc.c           | 1 -
>  drivers/usb/gadget/lpc32xx_udc.c       | 1 -
>  drivers/usb/gadget/m66592-udc.c        | 1 -
>  drivers/usb/gadget/mv_u3d_core.c       | 1 -
>  drivers/usb/gadget/mv_udc_core.c       | 1 -
>  drivers/usb/gadget/net2272.c           | 1 -
>  drivers/usb/gadget/net2280.c           | 1 -
>  drivers/usb/gadget/omap_udc.c          | 1 -
>  drivers/usb/gadget/pch_udc.c           | 1 -
>  drivers/usb/gadget/pxa25x_udc.c        | 1 -
>  drivers/usb/gadget/pxa27x_udc.c        | 1 -
>  drivers/usb/gadget/r8a66597-udc.c      | 1 -
>  drivers/usb/gadget/s3c-hsotg.c         | 1 -
>  drivers/usb/gadget/s3c-hsudc.c         | 1 -
>  drivers/usb/gadget/s3c2410_udc.c       | 1 -
>  drivers/usb/gadget/udc-core.c          | 3 ---
>  drivers/usb/musb/musb_gadget.c         | 1 -
>  drivers/usb/renesas_usbhs/mod_gadget.c | 1 -
>  include/linux/usb/gadget.h             | 4 ----
>  30 files changed, 35 deletions(-)
> 
[snip]
> diff --git a/drivers/usb/gadget/udc-core.c
> b/drivers/usb/gadget/udc-core.c index 9195054..4ee0efc 100644
> --- a/drivers/usb/gadget/udc-core.c
> +++ b/drivers/usb/gadget/udc-core.c
> @@ -173,7 +173,6 @@ int usb_add_gadget_udc(struct device *parent, struct
> usb_gadget *gadget) if (!udc)
>  		goto err1;
> 
> -	if (gadget->register_my_device) {
>  		dev_set_name(&gadget->dev, "gadget");
> 
>  		ret = device_register(&gadget->dev);
> @@ -211,7 +210,6 @@ err3:
>  	put_device(&udc->dev);
> 
>  err2:
> -	if (gadget->register_my_device)
>  		put_device(&gadget->dev);
>  err1:
>  	return ret;
> @@ -267,7 +265,6 @@ found:
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	device_unregister(&udc->dev);
> 
> -	if (gadget->register_my_device)
>  		device_unregister(&gadget->dev);

Correct me if I am wrong, but doesn't this patch leave us with incorrect 
indentation?

Otherwise looks good.

Best regards,
Tomasz Figa
