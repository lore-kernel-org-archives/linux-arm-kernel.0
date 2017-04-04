From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Apr 2017 15:20:01 +0200
Subject: [RFC PATCH v2 1/4] dt-bindings: update the Allwinner GPADC
 device tree binding for H3
In-Reply-To: <e4d50e78-afe7-6107-6d9a-15e4c732d79a@aosc.io>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-2-icenowy@aosc.io>
 <20170403091523.6atl7nq4m2qkpn3d@lukather>
 <e4d50e78-afe7-6107-6d9a-15e4c732d79a@aosc.io>
Message-ID: <20170404132001.4et5yaovpnqmbe6v@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 05:31:11PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?04?03? 17:15, Maxime Ripard ??:
> > On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:
> > > Allwinner H3 features a thermal sensor like the one in A33, but has its
> > > register re-arranged, the clock divider moved to CCU (originally the
> > > clock divider is in ADC) and added a pair of bus clock and reset.
> > > 
> > > Update the binding document to cover H3.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23 ++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > index badff3611a98..7753133ca0ff 100644
> > > --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> > >  and sometimes as a touchscreen controller.
> > > 
> > >  Required properties:
> > > -  - compatible: "allwinner,sun8i-a33-ths",
> > > +  - compatible: must contain one of the following compatibles:
> > > +		- "allwinner,sun8i-a33-ths"
> > > +		- "allwinner,sun8i-h3-ths"
> > >    - reg: mmio address range of the chip,
> > >    - #thermal-sensor-cells: shall be 0,
> > >    - #io-channel-cells: shall be 0,
> > > 
> > > -Example:
> > > +Required properties for the following compatibles:
> > > +		- "allwinner,sun8i-h3-ths"
> > > +  - clocks: the bus clock and the input clock of the ADC,
> > > +  - clock-names: should be "bus" and "ths",
> > 
> > I guess mod instead of ths would be more consistent.
> 
> In fact I will prefer "sample" here if not "ths", as it's used
> for the sampling, not like other mod clocks, which controls
> all the IP block's logic.

All the other mod clocks control some sort of sampling. The audio mod
clocks will be used to sample data in capture, same thing for NAND,
MMC, SPI, etc.

Please remain consistent.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/20f20626/attachment.sig>
