From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 27 Jun 2012 14:20:06 +0800
Subject: [PATCH v7 14/14] usb: chipidea: add imx platform driver
In-Reply-To: <4FE83E96.5090004@pengutronix.de>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-15-git-send-email-richard.zhao@freescale.com>
 <4FE83E96.5090004@pengutronix.de>
Message-ID: <20120627062005.GB21750@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 12:33:58PM +0200, Marc Kleine-Budde wrote:
> On 06/25/2012 08:56 AM, Richard Zhao wrote:
> > This patch supports only the host-mode functionality so far.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Peter Chen <peter.chen@freescale.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Tested-by: Subodh Nijsure <snijsure@grid-net.com>
> > ---
> >  .../devicetree/bindings/usb/ci13xxx-imx.txt        |   20 ++
> >  drivers/usb/chipidea/Makefile                      |    3 +
> >  drivers/usb/chipidea/ci13xxx_imx.c                 |  197 ++++++++++++++++++++
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >  create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > new file mode 100644
> > index 0000000..8bcd071
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > @@ -0,0 +1,20 @@
> > +* Freescale i.MX ci13xxx usb controllers
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,imx27-usb"
> > +- reg: Should contain registers location and length
> > +- interrupts: Should contain controller interrupt
> > +
> > +Optional properties:
> > +- fsl,usbphy: phandler of usb phy that connects to the only one port
> 
> > +- fsl,hub-reset-gpios: gpio used to reset on-board usb hub
> > +- fsl,vbus-power-gpios: gpio used to set vbus power of the only one port
> 
> These two properties are not implemented, are they?
> vbus is handled via a fixed regulator.
I forgot to update the doc.
> 
> Further I'm looking into the phy and otg implementation. I think the
> handling of the regulator should go into mxs-phy.c, not into the
> ci13xxx_imx.c
Normally, we don't put it in phy driver. For example, most host driver
don't call phy drivers.

Thanks
Richard
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 
> 
