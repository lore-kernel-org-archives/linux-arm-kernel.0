From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 19 Jul 2016 09:47:00 +0800
Subject: [PATCH 2/4] doc: usb: ci-hdrc-usb2: add property
 over-current-polarity
In-Reply-To: <578CF4C2.4000804@gmail.com>
References: <1468840547-17899-1-git-send-email-jun.li@nxp.com>
 <1468840547-17899-2-git-send-email-jun.li@nxp.com>
 <578CF4C2.4000804@gmail.com>
Message-ID: <20160719014700.GH31293@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 08:24:50AM -0700, Joshua Clayton wrote:
> Greetings,
> On 07/18/2016 04:15 AM, Li Jun wrote:
> > Adding over-current-polarity to indicate the over current flag
> > is low active or high active.
> >
> > Signed-off-by: Li Jun <jun.li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > index 341dc67..c5d35f4 100644
> > --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > @@ -81,6 +81,8 @@ i.mx specific properties
> >  - fsl,usbmisc: phandler of non-core register device, with one
> >    argument that indicate usb controller index
> >  - disable-over-current: disable over current detect
> > +- over-current-polarity: 0 if the over current signal polarity is low active,
> > +  1 if the over current signal polarity is high active.
> >  - external-vbus-divider: enables off-chip resistor divider for Vbus
> >  
> >  Example:
> The gpio device bindings already have active low/ active high.
> Could that be used here?
> 

No, the over current pin is a dedicated pin for USB, you need
to configure it through pinmux. If we are using a gpio (even
the same pin as OC pin), the USB subsystem will not know
OC event. The polarity is for OC pin and configured through
USB register.

> In the imx SPI subsystem, for instance, the developers used gpio rather than
> MUXED spi chipselect lines for exactly this kind of flexibility.
> 
> If there is no magic happening in silicon (which would seem to be the case if we can
> handle inverting polarity in the driver), I would suggest going the gpiod route.
> 

-- 

Best Regards,
Peter Chen
