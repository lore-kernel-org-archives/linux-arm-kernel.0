From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Aug 2016 17:43:51 +0100
Subject: [PATCH] USB: ohci-omap - avoid including mach/irqs.h
In-Reply-To: <Pine.LNX.4.44L0.1608221128050.1543-100000@iolanthe.rowland.org>
References: <E1bamhf-0004XR-Nk@rmk-PC.armlinux.org.uk>
 <Pine.LNX.4.44L0.1608221128050.1543-100000@iolanthe.rowland.org>
Message-ID: <20160826164351.GV5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 11:28:21AM -0400, Alan Stern wrote:
> On Fri, 19 Aug 2016, Russell King wrote:
> 
> > ohci-omap doesn't need to include mach/irqs.h - nothing within this
> > driver needs anything from this header file.  Remove this include.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/usb/host/ohci-omap.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> > index de7c68602a7e..495c1454b9e8 100644
> > --- a/drivers/usb/host/ohci-omap.c
> > +++ b/drivers/usb/host/ohci-omap.c
> > @@ -36,7 +36,6 @@
> >  #include <mach/mux.h>
> >  
> >  #include <mach/hardware.h>
> > -#include <mach/irqs.h>
> >  #include <mach/usb.h>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks.  Will Greg be picking this up?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
