From: greg@kroah.com (Greg KH)
Date: Mon, 29 Sep 2014 11:48:43 -0400
Subject: [PATCH] usb: gadget: uvc: fix up uvcg_v4l2_get_unmapped_area typo
In-Reply-To: <1855096.u0jNJntfok@avalon>
References: <3777003.OnaxFdNv7R@wuerfel>
 <1855096.u0jNJntfok@avalon>
Message-ID: <20140929154843.GA32039@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 03:34:11PM +0300, Laurent Pinchart wrote:
> Hi Arnd,
> 
> Thank you for the patch.
> 
> On Monday 29 September 2014 14:30:20 Arnd Bergmann wrote:
> > Patch "usb: gadget: uvc: rename functions to avoid conflicts with host uvc"
> > renamed a lot of symbols but missed one references that was inside of
> > an #ifdef:
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:363:23: error:
> > 'uvcg_v4l2_get_unmapped_area' undeclared here (not in a function)
> > .get_unmapped_area = uvcg_v4l2_get_unmapped_area,
> >                        ^
> > drivers/usb/gadget/function/uvc_v4l2.c:344:22: warning:
> > 'uvc_v4l2_get_unmapped_area' defined but not used [-Wunused-function]
> > static unsigned long uvc_v4l2_get_unmapped_area(struct file *file, ^
> > 
> > This renames the reference according the changed function name.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 7ea95b110811 ("usb: gadget: uvc: rename functions to avoid conflicts
> > with host uvc") Cc: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> > Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: linux-usb at vger.kernel.org
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Felipe, could you please this up ?

I can take it.

thanks,

greg k-h
