From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Dec 2013 14:37:52 +0100
Subject: [PATCH v6 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <20131204112039.GC907@lee--X1>
References: <1386153615-25456-1-git-send-email-k.kozlowski@samsung.com>
 <1386153615-25456-4-git-send-email-k.kozlowski@samsung.com>
 <20131204112039.GC907@lee--X1>
Message-ID: <1386164272.6195.3.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-04 at 11:20 +0000, Lee Jones wrote:
> > Add document describing device tree bindings for MAX14577 MFD driver.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/max14577.txt |   48 ++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
> > new file mode 100644
> > index 000000000000..f4fd16360b6b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/max14577.txt
> > @@ -0,0 +1,48 @@
> > +MAXIM MAX14577 multi-function device
> 
> Why is Maxim capitalised in such a way?
> 
> If you're going to use the term Multi-Function Device, please
> capitalise it.
> 
> > +MAX14577 is a Multi-function device with Micro-USB Interface Circuit, Li+
> 
> Same here.

I'll fix this. The MAXIM capitalization came from other drivers.

> > +Battery Charger and SFOUT LDO output for powering USB devices. It is
> > +interfaced to host controller using I2C.
> > +
> > +Required properties:
> > +- compatible : Must be "maxim,max14577".
> > +- reg : I2C slave address for the max14577 chip.
> > +- interrupts : IRQ line for the max14577 chip.
> > +- interrupt-parent :  The parent interrupt controller.
> > +
> > +Optional nodes:
> > +- regulators :
> > +  Required child node properties:
> > +  - compatible : "maxim,max14577-regulator"
> > +
> > +  Optional child nodes:
> > +    Each child node representing a regulator, following standard regulator
> > +    bindings. Valid names for a regulator are: "CHARGER" and "SAFEOUT".
> > +    The SAFEOUT is a constant voltage regulator so there is no need
> 
> s/constant/fixed
OK.

> > +    to specify voltages for it.
> 
> The whole of the "Optional nodes" explaination isn't as clear as it
> could otherwise be. 
> 
> > +	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
> > +
> > +Example:
> > +	max14577 at 25 {
> > +		compatible = "maxim,max14577";
> > +		reg = <0x25>;
> > +		interrupt-parent = <&gpx1>;
> > +		interrupts = <5 0>;
> 
> I'm gussing this is IRQ5 and the 0 is flags? If so, please use
> #defines for the flags.

This is a standard interrupt binding. The max14577 MFD core driver
ignores the interrupt flags and always uses IRQF_TRIGGER_FALLING. I can
fix this with new patch for drivers/mfd/max14577.c but still I don't see
what should be added in documentation.


Best regards,
Krzysztof
