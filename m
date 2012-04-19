From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Apr 2012 22:24:54 +0800
Subject: [PATCH 05/10] MXS: Add platform registration hooks for USB EHCI
In-Reply-To: <201204191151.46590.arnd@arndb.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
 <1334771194-18688-6-git-send-email-marex@denx.de>
 <201204191151.46590.arnd@arndb.de>
Message-ID: <20120419142452.GC22219@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 11:51:46AM +0000, Arnd Bergmann wrote:
> On Wednesday 18 April 2012, Marek Vasut wrote:
> >  arch/arm/mach-mxs/devices-mx28.h                |    4 ++
> >  arch/arm/mach-mxs/devices/Kconfig               |    3 +
> >  arch/arm/mach-mxs/devices/Makefile              |    1 +
> >  arch/arm/mach-mxs/devices/platform-usb.c        |   78 +++++++++++++++++++++++
> >  arch/arm/mach-mxs/include/mach/devices-common.h |    9 +++
> >  5 files changed, 95 insertions(+)
> >  create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
> 
> What's the state of the device tree support for mach-mxs now?

The pinctrl-mxs (DT only) was just posted today.  The gpio-mxs will
be the next one I will work on, and I think Dong Aisheng is adding
DT support for mxs-dma and mxs-mmc.  I believe we will reach a pretty
good state when in the v3.5 merge window.

> Since we
> allow booting at least the mx28evk with device tree now in -next, it
> would be really nice if we didn't have to add this registration code
> for non-DT platforms any more and just mandate that everyone who
> wants to use USB on that board uses DT.

I share the same view on this.

Regards,
Shawn

> Is that possible already
> or are we missing too much other stuff?
> 
