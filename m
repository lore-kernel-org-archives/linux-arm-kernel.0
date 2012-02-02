From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 Feb 2012 21:45:50 +0200
Subject: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <20120202191630.GT15343@ponder.secretlab.ca>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
 <1328203851-20435-2-git-send-email-tarun.kanti@ti.com>
 <20120202184106.GC29215@legolas.emea.dhcp.ti.com>
 <20120202191630.GT15343@ponder.secretlab.ca>
Message-ID: <20120202194545.GA29351@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 12:16:30PM -0700, Grant Likely wrote:
> On Thu, Feb 02, 2012 at 08:41:07PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Feb 02, 2012 at 11:00:27PM +0530, Tarun Kanti DebBarma wrote:
> > > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > > index 0b05629..6ea7390 100644
> > > --- a/drivers/gpio/gpio-omap.c
> > > +++ b/drivers/gpio/gpio-omap.c
> > > @@ -28,7 +28,10 @@
> > >  #include <asm/gpio.h>
> > >  #include <asm/mach/irq.h>
> > >  
> > > +static LIST_HEAD(omap_gpio_list);
> > 
> > I guess it's now too late because patch is acked and everything, but I
> > think if you make the driver handle one bank alone and just instantiate
> > it multiple times (omap_gpio.0, omap_gpio.1, omap_gpio.3, etc) driver
> > would be faaaaaar simpler.
> 
> Is there any shared state between the banks?  On my very cursory glance it
> looked like banks still have some interaction between them.  If not, then
> yes I agree that multiple instances would be better.

A quick glance at the TRM shows that banks have separate address spaces
and IRQ lines. I think it's done this way because we can handoff one (or
more) bank to other cores on the SoC, so they need to be pretty
independent.

I could be missing something though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/6eb340d8/attachment-0001.sig>
