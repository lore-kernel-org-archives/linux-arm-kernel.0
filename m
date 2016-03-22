From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 22 Mar 2016 21:12:56 +0100
Subject: [PATCH] musb: sunxi-glue: Fix sunxi-musb driver not auto-loading
In-Reply-To: <1458598418-16959-1-git-send-email-hdegoede@redhat.com>
References: <1458598418-16959-1-git-send-email-hdegoede@redhat.com>
Message-ID: <56F1A748.6070808@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Am 21.03.2016 um 23:13 schrieb Hans de Goede:
> Add a missing MODULE_DEVICE_TABLE() line which was causing the
> sunxi-musb glue to not auto-load when build as a module.

"built"

> 

Should this get a Fixes: header for backporting to stable?

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/musb/sunxi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index 4b472b8..9af9431 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -756,6 +756,7 @@ static const struct of_device_id sunxi_musb_match[] = {
>  	{ .compatible = "allwinner,sun8i-a33-musb", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, sunxi_musb_match);
>  
>  static struct platform_driver sunxi_musb_driver = {
>  	.probe = sunxi_musb_probe,

Has anyone looked into my earlier report about the module filename not
having musb-? I did not see any response and haven't rechecked v4.5.0.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
