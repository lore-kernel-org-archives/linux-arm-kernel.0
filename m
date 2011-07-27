From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 27 Jul 2011 16:42:40 -0400 (EDT)
Subject: [PATCH] usb/ehci-mxc: add missing inclusion of mach/hardware.h
In-Reply-To: <20110727020951.GF19600@S2100-06.ap.freescale.net>
Message-ID: <Pine.LNX.4.44L0.1107271641200.2738-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jul 2011, Shawn Guo wrote:

> Hi Alan,
> 
> Linus tree is currently failing on i.mx build because of this.

Greg KH is the USB maintainer.  He's on vacation right now, but he'll
merge your patch when he has a chance.

Alan Stern

> Regards,
> Shawn
> 
> On Thu, Jul 21, 2011 at 10:24:10PM +0800, Shawn Guo wrote:
> > As cpu_is_mx stuff is being used in the driver, header mach/hardware.h
> > should be explicitly included.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > The missing of the header is causing today's linux-next build error
> > as bleow.
> > 
> >   CC      drivers/usb/host/ehci-hcd.o
> > In file included from linux-next/drivers/usb/host/ehci-hcd.c:1190:0:
> > linux-next/drivers/usb/host/ehci-mxc.c: In function 'ehci_mxc_drv_probe':
> > linux-next/drivers/usb/host/ehci-mxc.c:175:2: error: implicit declaration of function 'cpu_is_mx35'
> > linux-next/drivers/usb/host/ehci-mxc.c:175:2: error: implicit declaration of function 'cpu_is_mx25'
> > linux-next/drivers/usb/host/ehci-mxc.c:185:2: error: implicit declaration of function 'cpu_is_mx51'
> > 
> >  drivers/usb/host/ehci-mxc.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> > index 0c058be..555a73c 100644
> > --- a/drivers/usb/host/ehci-mxc.c
> > +++ b/drivers/usb/host/ehci-mxc.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/usb/ulpi.h>
> >  #include <linux/slab.h>
> >  
> > +#include <mach/hardware.h>
> >  #include <mach/mxc_ehci.h>
> >  
> >  #include <asm/mach-types.h>
> > -- 
> > 1.7.4.1
