From: julia@diku.dk (Julia Lawall)
Date: Fri, 30 Jul 2010 17:14:46 +0200 (CEST)
Subject: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-Reply-To: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1007301712560.17618@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
> index 731150d..c266c1e 100644
> --- a/drivers/usb/gadget/amd5536udc.c
> +++ b/drivers/usb/gadget/amd5536udc.c
> @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
>  }
>  
>  /* Called by gadget driver to register itself */
> -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct udc		*dev = udc;
>  	int			retval;
>  	u32 tmp;
>  
> -	if (!driver || !driver->bind || !driver->setup
> +	if (!driver || bind || !driver->setup

Is it intentional that !driver->bind has become just bind in this case?  
That doesn't seem to happen in the other cases.

julia
