From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Tue, 08 Jul 2014 17:08:48 -0700 (PDT)
Subject: [PATCH 1/2] usb: renesas_usbhs: add R-Car Gen. 2 init and power
 control
In-Reply-To: <1404831571-19817-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1404831571-19817-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <87y4w3v1fa.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Ulrich

Thank you for your patch

> In preparation for DT conversion to reduce reliance on platform device
> callbacks.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
(snip)
> @@ -186,6 +192,8 @@ struct renesas_usbhs_platform_info {
>  	 * driver use these param for some register
>  	 */
>  	struct renesas_usbhs_driver_param	driver_param;
> +
> +	struct usb_phy *phy;
>  };

Using renesas_usbhs_platform_info for *phy is not good idea from my point of view.
Because its memory is located on platform side.
(this is the reason why usbhs_probe() using memcpy() for getting info->xxx)

I guess struct usbhs_priv is good place,
and you can use usbhs_pdev_to_priv() for this purpose ?

Best regards
---
Kuninori Morimoto
