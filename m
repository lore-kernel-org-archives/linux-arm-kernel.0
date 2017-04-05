From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 09:26:31 +0200
Subject: [PATCH 2/3] arm64: allwinner: a64: add USB0 OHCI/EHCI related
 devicetree parts
In-Reply-To: <7828ffa0-f570-9841-a9e6-fe175f8169ac@aosc.io>
References: <20170404184518.33610-1-icenowy@aosc.io>
 <20170404184518.33610-2-icenowy@aosc.io>
 <20170405071508.yaur35xuli4jgkfb@lukather>
 <7828ffa0-f570-9841-a9e6-fe175f8169ac@aosc.io>
Message-ID: <20170405072631.ou4e5gafvagwpykq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 03:17:19PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?04?05? 15:15, Maxime Ripard ??:
> > On Wed, Apr 05, 2017 at 02:45:17AM +0800, Icenowy Zheng wrote:
> > > As we added USB0 route auto switching support for A64, add related
> > > device tree parts to the A64 DTSI file (EHCI0/OHCI0 controllers and the
> > > pmu0 memory area for PHY).
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > index 1c64ea2d23f9..a8916df99048 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > @@ -179,8 +179,10 @@
> > >  		usbphy: phy at 01c19400 {
> > >  			compatible = "allwinner,sun50i-a64-usb-phy";
> > >  			reg = <0x01c19400 0x14>,
> > > +			      <0x01c1a800 0x4>,
> > >  			      <0x01c1b800 0x4>;
> > >  			reg-names = "phy_ctrl",
> > > +				    "pmu0",
> > 
> > This breaks the older DTs, and that property isn't documented.
> 
> It's already documented.
> 
> In the H3 dual-route patchset I have already added this.
> 
> ("  * "pmu0" for H3, V3s and A64")

This is not in linux-next then, sorry.

> P.S. to be compatible with older DTs, I think I should adjust
> the phy driver, make it enable dual-route function only when
> pmu0 is present.

That, or if we're quick enough, we can still add it to 4.11. There's a
bit of time left.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/b0ff295a/attachment.sig>
