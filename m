From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Sep 2015 12:06:17 +0200
Subject: [PATCH v8 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
In-Reply-To: <55FA7428.4030801@pengutronix.de>
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442402482-7118-2-git-send-email-info@gerhard-bertelsmann.de>
 <55FA7428.4030801@pengutronix.de>
Message-ID: <20150917100617.GB4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 10:04:56AM +0200, Marc Kleine-Budde wrote:
> On 09/16/2015 01:21 PM, Gerhard Bertelsmann wrote:
> > Devicetree bindings for Allwinner A10/A20 CAN
> > 
> > Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> > ---
> > 
> >  .../devicetree/bindings/net/can/sun4i_can.txt      |  38 +
> >  1 files changed, 389 insertions(+)
> > 
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/sun4i_can.txt b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> > new file mode 100644
> > index 0000000..cd0f50c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> > @@ -0,0 +1,38 @@
> > +Allwinner A10/A20 CAN controller Device Tree Bindings
> > +-----------------------------------------------------
> > +
> > +Required properties:
> > +- compatible: "allwinner,sun4i-a10-can"
> > +- reg: physical base address and size of the Allwinner A10/A20 CAN register map.
> > +- interrupts: interrupt specifier for the sole interrupt.
> > +- clock: phandle and clock specifier.
> > +
> > +
> > +Example
> > +-------
> > +
> > +SoC common .dtsi file:
> > +
> > +	can0_pins_a: can0 at 0 {
> > +		allwinner,pins = "PH20","PH21";
> > +		allwinner,function = "can";
> > +		allwinner,drive = <0>;
> > +		allwinner,pull = <0>;
> > +	};
> > +...
> > +	can0: can at 01c2bc00 {
> > +		compatible = "allwinner,sun4i-a10-can";
> > +		reg = <0x01c2bc00 0x400>;
> > +		interrupts = <0 26 4>;
> > +		clocks = <&apb1_gates 4>;
> > +		status = "disabled";
> > +	};
> 
> What about adding this snippet to SoC where the CAN core is available?
> Maxime, what's the policy on sinxi?

It would be great, but it can come as a second step.

> If you give me an Ack I'd like to take the series via linux-can-next
> (and to net-next) upstream.

I just did so for this patch, I'll review the driver when I'll have a
bit of time.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/97e96eb7/attachment.sig>
