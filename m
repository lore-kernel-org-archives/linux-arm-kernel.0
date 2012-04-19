From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Apr 2012 23:32:56 +0200
Subject: [PATCH 05/10] MXS: Add platform registration hooks for USB EHCI
In-Reply-To: <20120419142452.GC22219@S2101-09.ap.freescale.net>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <201204191151.46590.arnd@arndb.de>
 <20120419142452.GC22219@S2101-09.ap.freescale.net>
Message-ID: <201204192332.56957.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Thu, Apr 19, 2012 at 11:51:46AM +0000, Arnd Bergmann wrote:
> > On Wednesday 18 April 2012, Marek Vasut wrote:
> > >  arch/arm/mach-mxs/devices-mx28.h                |    4 ++
> > >  arch/arm/mach-mxs/devices/Kconfig               |    3 +
> > >  arch/arm/mach-mxs/devices/Makefile              |    1 +
> > >  arch/arm/mach-mxs/devices/platform-usb.c        |   78
> > >  +++++++++++++++++++++++
> > >  arch/arm/mach-mxs/include/mach/devices-common.h |    9 +++
> > >  5 files changed, 95 insertions(+)
> > >  create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
> > 
> > What's the state of the device tree support for mach-mxs now?
> 
> The pinctrl-mxs (DT only) was just posted today.  The gpio-mxs will
> be the next one I will work on, and I think Dong Aisheng is adding
> DT support for mxs-dma and mxs-mmc.  I believe we will reach a pretty
> good state when in the v3.5 merge window.

This is very good to hear, I'm really interested to see this development :)

> > Since we
> > allow booting at least the mx28evk with device tree now in -next, it
> > would be really nice if we didn't have to add this registration code
> > for non-DT platforms any more and just mandate that everyone who
> > wants to use USB on that board uses DT.
> 
> I share the same view on this.

The Device Tree code for MXS is not ripe yet. We still miss a lot in there. 
Flipping this usb stuff to DT should be easy, I see no point disallowing this 
(and that stands also for the MXS SPI actually) into kernel so more people can 
test it only because you'd like this to wait for who knows how long for the DT 
support to arrive. Don't take it personally, but I still believe it's too early 
to enforce DT on MXS.

> Regards,
> Shawn
> 
> > Is that possible already
> > or are we missing too much other stuff?

Best regards,
Marek Vasut
