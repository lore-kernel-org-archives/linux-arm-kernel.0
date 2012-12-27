From: marex@denx.de (Marek Vasut)
Date: Thu, 27 Dec 2012 08:21:55 +0100
Subject: [PATCH v4 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <1356591603-23323-4-git-send-email-peter.chen@freescale.com>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
 <1356591603-23323-4-git-send-email-peter.chen@freescale.com>
Message-ID: <201212270821.55253.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

[...]
> +
> +#define CI_VBUS_STABLE_TIMEOUT 500

Shall we not change this to static const int instead ?

[...]

> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1371,6 +1371,7 @@ static int ci13xxx_vbus_session(struct usb_gadget
> *_gadget, int is_active) pm_runtime_get_sync(&_gadget->dev);
>  			hw_device_reset(ci, USBMODE_CM_DC);
>  			hw_device_state(ci, ci->ep0out->qh.dma);
> +			dev_dbg(ci->dev, "Connected to host\n");
>  		} else {
>  			hw_device_state(ci, 0);
>  			if (ci->platdata->notify_event)
> @@ -1378,6 +1379,7 @@ static int ci13xxx_vbus_session(struct usb_gadget
> *_gadget, int is_active) CI13XXX_CONTROLLER_STOPPED_EVENT);
>  			_gadget_stop_activity(&ci->gadget);
>  			pm_runtime_put_sync(&_gadget->dev);
> +			dev_dbg(ci->dev, "disconnected from host\n");

Keep the capital letters at the begining of the sentence consistent -- either 
start with capital D here or fix the capital C above.

>  		}
>  	}
