From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 10:58:48 +0100
Subject: [PATCH 2/3] doc: dt-binding: generic onboard USB HUB
In-Reply-To: <1449568249.3691.15.camel@pengutronix.de>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-3-git-send-email-peter.chen@freescale.com>
 <1449568249.3691.15.camel@pengutronix.de>
Message-ID: <19094869.VEiW4FjBL1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 10:50:49 Philipp Zabel wrote:
> Am Dienstag, den 08.12.2015, 09:37 +0800 schrieb Peter Chen:
> > Add dt-binding documentation for generic onboard USB HUB.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  .../bindings/usb/generic-onboard-hub.txt           | 28 ++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> > new file mode 100644
> > index 0000000..ea92205
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> > @@ -0,0 +1,28 @@
> > +Generic Onboard USB HUB
> >+
> > +Required properties:
> > +- compatible: should be "generic-onboard-hub"
> 
> This something we don't have to define ad-hoc. The hub hangs off an USB
> controller, right? The "Open Firmware recommended practice: USB"
> document already describes how to represent USB devices in a generic
> manner:
> http://www.firmware.org/1275/bindings/usb/usb-1_0.ps
> 
> Is there a reason not to reuse this?
> 
> The usb hub node would be a child of the usb controller node, and it
> could use
> 	compatible = "usb,class9"; /* bDeviceClass 9 (Hub) */

Good point, I had not thought of that when I looked at the patches.

Yes, let's do this way. I don't know if we ever implemented the simple
patch to associate a USB device with a device_node, but if not, then
let's do it now for this driver. A lot of people have asked for it in
the past.

	Arnd
