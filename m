From: jikos@kernel.org (Jiri Kosina)
Date: Thu, 21 Jan 2016 14:37:29 +0100 (CET)
Subject: [PATCH] hid: add support for Lilliput touchscreen
In-Reply-To: <1449863264-14184-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449863264-14184-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <alpine.LNX.2.00.1601211435360.21446@cbobk.fhfr.pm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Dec 2015, Srinivas Kandagatla wrote:

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c6f7a69..4350376 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2051,6 +2051,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LILLIPUT, USB_PROD_ID_LILLIPUT) },

Could you please keep the list sorted?

>  
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 9024a3d..f87993f 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1055,4 +1055,8 @@
>  #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
>  #define USB_DEVICE_ID_RAPHNET_4NES4SNES	0x0003
>  
> +/* Lilliput Capacitive TouchScreen */
> +#define USB_VENDOR_ID_LILLIPUT  0x1391
> +#define USB_PROD_ID_LILLIPUT    0x2112
> +
>  #endif
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 3d664d0..580749e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1209,6 +1209,11 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
>  			USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040) },
>  
> +	/* Lilliput multitouch panels */
> +	{  .driver_data = MT_CLS_DEFAULT,
> +		HID_USB_DEVICE(USB_VENDOR_ID_LILLIPUT,
> +			USB_PROD_ID_LILLIPUT) },
> +

This is a bit out of order as well.

Thanks,

-- 
Jiri Kosina
SUSE Labs
