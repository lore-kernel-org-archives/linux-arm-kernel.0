From: peter.senna@collabora.co.uk (Peter Senna Tschudin)
Date: Tue, 03 Jan 2017 23:34:04 +0000
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?= V7 =?utf-8?q?1=2F4=5D?=
 =?utf-8?q?_Documentation=2Fdevicetree=2Fbindings=3A?=
 =?utf-8?q?_b850v3=5Flvds=5Fdp?=
In-Reply-To: <20170103225127.jn36tatufdfz2k5q@rob-hp-laptop>
Message-ID: <529b-586c3500-5-5e05b080@98620974>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Rob,

Thank you for the review.

On 03 January, 2017 23:51 CET, Rob Herring <robh@kernel.org> wrote: 
 
> On Sun, Jan 01, 2017 at 09:24:29PM +0100, Peter Senna Tschudin wrote:
> > Devicetree bindings documentation for the GE B850v3 LVDS/DP++
> > display bridge.
> > 
> > Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> > Cc: Martin Donnelly <martin.donnelly@ge.com>
> > Cc: Javier Martinez Canillas <javier@dowhile0.org>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> > ---
> > There was an Acked-by from Rob Herring <robh@kernel.org> for V6, but I changed
> > the bindings to use i2c_new_secondary_device() so I removed it from the commit
> > message.
> > 
> >  .../devicetree/bindings/ge/b850v3-lvds-dp.txt      | 39 ++++++++++++++++++++++
> 
> Generally, bindings are not organized by vendor. Put in 
> bindings/display/bridge/... instead.

Will change that.

> 
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt b/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
> > new file mode 100644
> > index 0000000..1bc6ebf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
> > @@ -0,0 +1,39 @@
> > +Driver for GE B850v3 LVDS/DP++ display bridge
> > +
> > +Required properties:
> > +  - compatible : should be "ge,b850v3-lvds-dp".
> 
> Isn't '-lvds-dp' redundant? The part# should be enough.

b850v3 is the name of the product, this is why the proposed name. What about, b850v3-dp2 dp2 indicating the second DP output?

> 
> > +  - reg : should contain the main address which is used to ack the
> > +    interrupts and address for edid.
> > +  - reg-names : comma separeted list of register names. Valid values
> 
> s/separeted/separated/

argh, sorry for this. Will fix it.

> 
> > +    are "main", and "edid".
> > +  - interrupt-parent : phandle of the interrupt controller that services
> > +    interrupts to the device
> > +  - interrupts : one interrupt should be described here, as in
> > +    <0 IRQ_TYPE_LEVEL_HIGH>.
> > +  - port : should describe the video signal connection between the host
> > +    and the bridge.
> > +
> > +Example:
> > +
> > +&mux2_i2c2 {
> > +	status = "okay";
> > +	clock-frequency = <100000>;
> > +
> > +	b850v3-lvds-dp-bridge at 73  {
> > +		compatible = "ge,b850v3-lvds-dp";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg = <0x73 0x72>;
> > +		reg-names = "main", "edid";
> > +
> > +		interrupt-parent = <&gpio2>;
> > +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +		port {
> > +			b850v3_dp_bridge_in: endpoint {
> > +				remote-endpoint = <&lvds0_out>;
> > +			};
> > +		};
> > +	};
> > +};
> > -- 
> > 2.5.5
> > 
 
 
 
 
