From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 10:26:46 +0100
Subject: [linux-sunxi] [PATCH v2 1/4] dt-bindings: pwm: binding allwinner
 sun8i.
In-Reply-To: <56645bca-9f4a-3191-72d8-32b60ebbc26e@arm.com>
References: <20180225135045.GA14508@arx-s1>
 <56645bca-9f4a-3191-72d8-32b60ebbc26e@arm.com>
Message-ID: <20180301092646.44rxuwui2ssiar4u@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 28, 2018 at 01:51:59AM +0000, Andr? Przywara wrote:
> On 25/02/18 13:50, hao_zhang wrote:
> > This patch adds allwinner sun8i pwm binding documents.
> > 
> > Signed-off-by: hao_zhang <hao5781286@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > new file mode 100644
> > index 0000000..e8c48be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > @@ -0,0 +1,18 @@
> > +Allwinner sun8i R40/V40/T3 SoC PWM controller
> > +
> > +Required properties:
> > +  - compatible: should be one of:
> > +    - "allwinner,sun8i-r40-pwm"
> > +  - reg: physical base address and length of the controller's registers
> > +  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> > +    the cells format.
> > +  - clocks: From common clock binding, handle to the parent clock.
> 
> The manual tells me that there are two possible clock sources (24 MHz
> OSC and APB1), with actually two bits for encoding the mux source,
> allowing for two more potential clock sources.
> So can we extend this description to provide up to four clocks, with a
> clock-names property telling the driver how this maps to the mux value?
> Either we use clock names matching the clocks mentioned in the manual:
> 	clocks = <&osc24M>, <&ccu CLK_APB1>;
> 	clock-names = "osc", "apb1";
> or we encode the mux values in the clock-names:
> 	clock-names = "mux-0", "mux-1";

I'd prefer the former.

> Don't know what's more widely used in those cases, the latter seems to
> be more future-proof.

Not really, nothing prevents the next generation to have three bits,
or even 32 bits to do the muxing :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/a9bccc06/attachment.sig>
