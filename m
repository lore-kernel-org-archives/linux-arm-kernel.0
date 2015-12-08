From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 10:45:44 +0100
Subject: [PATCH 2/3] doc: dt-binding: generic onboard USB HUB
In-Reply-To: <20151208092045.GB16881@shlinux2>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <CAOMZO5DfBW3hxp5odbefLQCmkocPy=LypVW5HJWzDkF__WD_sg@mail.gmail.com>
 <20151208092045.GB16881@shlinux2>
Message-ID: <2137754.fyz9D1aof4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 17:20:46 Peter Chen wrote:
> On Tue, Dec 08, 2015 at 12:30:59AM -0200, Fabio Estevam wrote:
> > On Mon, Dec 7, 2015 at 11:37 PM, Peter Chen <peter.chen@freescale.com> wrote:
> > > Add dt-binding documentation for generic onboard USB HUB.
> > >
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > ---
> > >  .../bindings/usb/generic-onboard-hub.txt           | 28 ++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> > > new file mode 100644
> > > index 0000000..ea92205
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> > > @@ -0,0 +1,28 @@
> > > +Generic Onboard USB HUB
> > > +
> > > +Required properties:
> > > +- compatible: should be "generic-onboard-hub"
> > > +
> > > +Optional properties:
> > > +- clocks: the input clock for HUB.
> > > +
> > > +- clock-names: Should be "external_clk"

Make this just "external", or remove the name and use it as an anonymous clock.

> > > +- hub-reset-gpios: Should specify the GPIO for reset.
> > > +
> > > +- hub-reset-active-high: the active reset signal is high, if this property is
> > > +  not set, the active reset signal is low.
> > > +
> > > +- hub-reset-duration-us: the duration for assert reset signal, the time unit
> > > +  is microsecond.

Remove the "hub-" prefix here.

> > > +Example:
> > > +
> > > +       usb_hub1 {
> > > +               compatible = "generic-onboard-hub";
> > > +               clocks = <&clks IMX6QDL_CLK_CKO>;
> > > +               clock-names = "external_clk";
> > > +               hub-reset-gpios = <&gpio7 12 0>;
> > > +               hub-reset-active-high;
> > 
> > I think you could drop the 'hub-reset-active-high' property and do
> > like this instead:
> > 
> > hub-reset-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> > 
> > or
> > 
> > hub-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> 
> Yes, you are right, would you have a test to see if can work for
> udoo board?

Yes, it should be done like this.

	Arnd
