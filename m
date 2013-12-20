From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 20 Dec 2013 14:05:42 -0300
Subject: [PATCH] usb: musb: Remove USB_GADGET driver dependency
In-Reply-To: <20131220154958.GA5957@saruman.home>
References: <1387502448-11041-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131220154958.GA5957@saruman.home>
Message-ID: <20131220170541.GA16652@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 09:49:58AM -0600, Felipe Balbi wrote:
> On Thu, Dec 19, 2013 at 10:20:48PM -0300, Ezequiel Garcia wrote:
> > This USB controller is dual-role, but can also work in host-only mode.
> > There's no reason to condition the entire driver to USB_GADGET. Fix this by
> > removing the dependency.
> > 
> > Tested on a Beaglebone black (AM335x) using a regular USB mass storage
> > device.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/usb/musb/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > index 57dfc0c..2119370 100644
> > --- a/drivers/usb/musb/Kconfig
> > +++ b/drivers/usb/musb/Kconfig
> > @@ -6,7 +6,6 @@
> >  # (M)HDRC = (Multipoint) Highspeed Dual-Role Controller
> >  config USB_MUSB_HDRC
> >  	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> > -	depends on USB_GADGET
> 
> the correct patch would be to turn this into (USB || USB_GADGET) and fix
> the mode selection just like dwc3 is doing.
> 

Ah, I see now. Let me prepare a v2 then.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
