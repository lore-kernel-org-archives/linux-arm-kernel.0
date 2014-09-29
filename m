From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 29 Sep 2014 15:34:11 +0300
Subject: [PATCH] usb: gadget: uvc: fix up uvcg_v4l2_get_unmapped_area typo
In-Reply-To: <3777003.OnaxFdNv7R@wuerfel>
References: <3777003.OnaxFdNv7R@wuerfel>
Message-ID: <1855096.u0jNJntfok@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thank you for the patch.

On Monday 29 September 2014 14:30:20 Arnd Bergmann wrote:
> Patch "usb: gadget: uvc: rename functions to avoid conflicts with host uvc"
> renamed a lot of symbols but missed one references that was inside of
> an #ifdef:
> 
> drivers/usb/gadget/function/uvc_v4l2.c:363:23: error:
> 'uvcg_v4l2_get_unmapped_area' undeclared here (not in a function)
> .get_unmapped_area = uvcg_v4l2_get_unmapped_area,
>                        ^
> drivers/usb/gadget/function/uvc_v4l2.c:344:22: warning:
> 'uvc_v4l2_get_unmapped_area' defined but not used [-Wunused-function]
> static unsigned long uvc_v4l2_get_unmapped_area(struct file *file, ^
> 
> This renames the reference according the changed function name.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7ea95b110811 ("usb: gadget: uvc: rename functions to avoid conflicts
> with host uvc") Cc: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Felipe, could you please this up ?

> ---
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c
> b/drivers/usb/gadget/function/uvc_v4l2.c index b52f2681ec21..5aad7fededa5
> 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -341,7 +341,7 @@ uvc_v4l2_poll(struct file *file, poll_table *wait)
>  }
> 
>  #ifndef CONFIG_MMU
> -static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
> +static unsigned long uvcg_v4l2_get_unmapped_area(struct file *file,
>  		unsigned long addr, unsigned long len, unsigned long pgoff,
>  		unsigned long flags)
>  {

-- 
Regards,

Laurent Pinchart
