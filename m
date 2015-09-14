From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Sep 2015 15:30:22 +0200
Subject: [PATCH v6 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
In-Reply-To: <55F6C46D.7090203@pengutronix.de>
References: <1442235299-5885-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442235299-5885-2-git-send-email-info@gerhard-bertelsmann.de>
 <55F6C46D.7090203@pengutronix.de>
Message-ID: <20150914133022.GB4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 14, 2015 at 02:58:21PM +0200, Marc Kleine-Budde wrote:
> On 09/14/2015 02:54 PM, Gerhard Bertelsmann wrote:
> > Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> > ---
> > 
> >  .../devicetree/bindings/net/can/sun4i_can.txt      |  37 +
> >  1 files changed, 37 insertions(+)
> > 
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/sun4i_can.txt b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> > new file mode 100644
> > index 0000000..b572e2b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> > @@ -0,0 +1,37 @@
> > +Allwinner A10/A20 CAN controller Device Tree Bindings
> > +-----------------------------------------------------
> > +
> > +Required properties:
> > +- compatible: "allwinner,sunxican"
> > +- reg: physical base address and size of the Allwinner A10/A20 CAN register map.
> > +- interrupts: interrupt specifier for the sole interrupt.
> > +- clock: phandle and clock specifier.
> > +
> > +Example
> > +-------
> > +
> > +SoC common .dtsi file:
> > +
> > +	can0_pins_a: can0 <at> 0 {
> 
> That's supposed to be a proper "@":
> 
>     can0 at 0
> 
> > +		allwinner,pins = "PH20","PH21";
> > +		allwinner,function = "can";
> > +		allwinner,drive = <0>;
> > +		allwinner,pull = <0>;
> > +	};
> > +
> > +	can0: can <at> 01c2bc00 {
> 
>     can0 at 01c2bc00

Actually, beside '<at>' vs '@', he was right.

The name of the node in the DT should be:

<device class>@<address>

Which in our case is can at 01c2bc00, like he used.

> 
> > +		compatible = "allwinner,sunxican";

However, the compatible is still not right.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/2ce4e278/attachment-0001.sig>
