From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 23 Jan 2013 15:36:17 -0800
Subject: [PATCH v9 20/20] mdf: omap-usb-host: get rid of build warning
In-Reply-To: <1358937492-8129-21-git-send-email-rogerq@ti.com>
References: <1358937492-8129-1-git-send-email-rogerq@ti.com>
 <1358937492-8129-21-git-send-email-rogerq@ti.com>
Message-ID: <20130123233617.9205.88295@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Roger Quadros (2013-01-23 02:38:12)
> Fixes the below build warning when driver is built-in.
> 
> drivers/mfd/omap-usb-host.c:750:12: warning:
> ?usbhs_omap_remove? defined but not used [-Wunused-function]
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Hi Roger,

I just noticed that $SUBJECT says "mdf" instead of "mfd" ;)

Regards,
Mike

> ---
>  drivers/mfd/omap-usb-host.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index b21ca76..6b5edf6 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -791,7 +791,7 @@ static struct platform_driver usbhs_omap_driver = {
>                 .owner          = THIS_MODULE,
>                 .pm             = &usbhsomap_dev_pm_ops,
>         },
> -       .remove         = __exit_p(usbhs_omap_remove),
> +       .remove         = usbhs_omap_remove,
>  };
>  
>  MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
