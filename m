From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Nov 2012 08:37:11 +0100
Subject: [PATCH v3 3/7] usb: chipidea: usbmisc: fix a potential race
 condition
In-Reply-To: <20121123053635.GB22420@nchen-desktop>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-4-git-send-email-m.grzeschik@pengutronix.de>
 <20121123053635.GB22420@nchen-desktop>
Message-ID: <20121123073711.GJ10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 01:36:36PM +0800, Peter Chen wrote:
> On Wed, Nov 21, 2012 at 03:06:29PM +0100, Michael Grzeschik wrote:
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > This fixes a potential race condition where the ci13xxx_imx glue code
> > could be fast enough to call one of the usbmisc_ops before he got a
> > valid value on the static usbmisc pointer. To fix that we first set
> > usbmisc, then call usbmisc_set_ops().
> 
> usbmisc is subsys_initcall, and cil13xxx_imx is module_init. Any
> potential situation that the ci13xxx_imx's probe is ran before the
> usbmisc's probe is completed?

Not having looked at the code you are referring to at all I just want
to say that: drivers can be modules (don't know if that's true for
chipidea) and sooner or later we'll probably get devicetree overlays, so
the devicetree nodes might just appear during runtime. Depending on
initcall order is generally not a good idea.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
