From: mgr@pengutronix.de (Michael Grzeschik)
Date: Thu, 19 Jul 2012 15:20:56 +0200
Subject: [PATCH] usb: chipidea: ci13xxx-imx: remove global struct
In-Reply-To: <20120719082856.GB11782@pengutronix.de>
References: <20120718233107.GA32622@pengutronix.de>
 <20120719082856.GB11782@pengutronix.de>
Message-ID: <20120719132056.GB7630@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thu, Jul 19, 2012 at 10:28:56AM +0200, Wolfram Sang wrote:
> On Thu, Jul 19, 2012 at 01:31:07AM +0200, Michael Grzeschik wrote:
> > This patch removes the limitation of having only one
> > instance of the ci13xxx-imx. Each instance of the ci13xxx-imx
> > could have different flags to be configured with, so we also
> > move this settings to the devicetree properties.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +++++
> 
> New bindings should always have devicetree-discuss in CC.

Right.

> 
> >  drivers/usb/chipidea/ci13xxx_imx.c                 |   25 +++++++++++---------
> >  drivers/usb/chipidea/core.c                        |   11 +++++++++
> >  include/linux/usb/chipidea.h                       |    3 +++
> >  4 files changed, 34 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > index 2c29041..5485eb9 100644
> > --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > @@ -8,6 +8,9 @@ Required properties:
> >  Optional properties:
> >  - fsl,usbphy: phandler of usb phy that connects to the only one port
> >  - vbus-supply: regulator for vbus
> > +- require-transceiver: enable the flag in the driver
> > +- pullup-on-vbus: enable the flag in the driver
> > +- disable-streaming: enable the flag in the driver
> 
> NACK to the bindings. You are mapping platform data 1:1 which is nearly
> always wrong. Having a quick look in the current devicetree bindings for
> USB shows that there is a transceiver property. So, the the
> (non-)presence of that property should make "require-transceiver"
> superfluous? Also, is "disable-streaming" a description of the hardware?

You are right it probably needs more investigation to decide which
condition leads to which flags. Its probably not the best thing to move
everything out to device tree.

Actually i am touching two thing at a time in this patch, removing the
static struct and setting the flags by oftree. I will resend this patch,
together with other work, and will just leave the flags as currently
set.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
