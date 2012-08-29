From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Aug 2012 10:10:20 +0200
Subject: [PATCH v6 1/3] USB: chipidea: add imx usbmisc support
In-Reply-To: <871uiqkuhb.fsf@ashishki-desk.ger.corp.intel.com>
References: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
 <1346137109-32247-2-git-send-email-richard.zhao@freescale.com>
 <871uiqkuhb.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120829081020.GX26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 10:50:08AM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > i.MX usb controllers shares non-core registers, which may include
> > SoC specific controls. We take it as a usbmisc device and usbmisc
> > driver set operations needed by ci13xxx_imx driver.
> >
> > For example, Sabrelite board has bad over-current design, we can
> > usbmisc to disable over-current detect.
> 
> Why does this have to be part of the usb driver instead of SoC specific
> code? It looks like you've created a whole new device/driver
> infrastructure just to disable overcurrent for a specific board.

Richards code indeed only handles overcurrent for a specific board, but
there are more bits to configure in the longer run: power pin
polarities, ULPI/serial mode select and some more.

> 
> And the infrastructure boils down to a complex way of passing a callback
> from imx driver to another imx driver, that only works if they are
> probed in the right order. I don't see any point in doing it like this
> other than inflating the device tree tables even further.
> 
> Why can't this be part of the SoC code like it is done, for example in
> arch/arm/mach-omap2/control.c?

The settings are board specific, so there must be some way to configure
them in the devicetree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
