From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 03 Sep 2012 17:21:22 -0700 (PDT)
Subject: [PATCH 05/11] ARM: shmobile: r8a7779: add USB common phy
 initializer
In-Reply-To: <201209032138.41485.arnd@arndb.de>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
 <1346376502-12114-6-git-send-email-horms@verge.net.au>
 <201209032138.41485.arnd@arndb.de>
Message-ID: <87k3wafxj4.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Simon

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > This patch adds common USB phy ports initializer for r8a7779.
> > 
> > The note is that each USB IP have own MSTP clock bit,
> > and common USB phy port doesn't have MSTP clock,
> > but this USB phy needs USB clock.
> > Each USB driver / platform should keep USB MSTP clock somehow.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/include/mach/common.h |  1 +
> >  arch/arm/mach-shmobile/setup-r8a7779.c       | 93 ++++++++++++++++++++++++++++
> >  2 files changed, 94 insertions(+)
> 
> Shouldn't the USB PHY driver go to drivers/usb/phy/ or
> drivers/usb/host/ehci-sh.c?
> 
> We are trying hard to move driver code out of the platform and into driver
> directories these days, and having it wired up as part of the platform
> the way you do also means it is always powered on.

I see.
I can move this code to under driver.
Can I send additional patch for it ?
 - move usb phy code to driver (to Simon, USB ML)

Or should I send multi patches ?
 - remove this patch (to Simon)
 - add usb phy driver patch (to USB ML)
 - use usb phy driver patch (to Simon)

> I see neither big-endian support on shmobile, nor any XHCI (USB-3.0) driver, just
> the old EHCI (USB-2.0) and OHCI (USB-1.1) drivers. Are you submitting the XHCI
> support and big-endian platform code separately?

Sorry for very confusing naming.
I fix it

Best regards
---
Kuninori Morimoto
