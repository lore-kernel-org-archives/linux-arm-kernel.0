From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 10:08:57 +0200
Subject: [linux-sunxi] Re: [PATCH 10/11] arm64: allwinner: a64: enable
 AXP803 regulators for Pine64
In-Reply-To: <20170405061552.C15201033DF@relay.mailchannels.net>
References: <20170405061552.C15201033DF@relay.mailchannels.net>
Message-ID: <20170405080857.hetsjgatyh6hbsoh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 02:15:43PM +0800, Icenowy Zheng wrote:
> 
> 2017?4?5? 14:13? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Wed, Apr 05, 2017 at 02:01:44AM +0800, Icenowy Zheng wrote: 
> > > Add support of AXP803 regulators in the Pine64 device tree, in order to 
> > > enable many future functionalities, e.g. Wi-Fi. 
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io> 
> > > --- 
> > >? .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 109 +++++++++++++++++++++ 
> > >? 1 file changed, 109 insertions(+) 
> > > 
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts 
> > > index 2132d8e6cb3d..7da074f95065 100644 
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts 
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts 
> > > @@ -106,6 +106,115 @@ 
> > >? }; 
> > >? }; 
> > >? 
> > > +#include "axp803.dtsi" 
> > > + 
> > > +&reg_aldo1 { 
> > > + regulator-min-microvolt = <2800000>; 
> > > + regulator-max-microvolt = <2800000>; 
> > > + regulator-name = "vcc-csi"; 
> > > +}; 
> > > + 
> > > +&reg_aldo2 { 
> > > + regulator-always-on; 
> > > + regulator-min-microvolt = <1800000>; 
> > > + regulator-max-microvolt = <3300000>; 
> > > + regulator-name = "vcc-pl"; 
> > > +}; 
> > > + 
> > > +&reg_aldo3 { 
> > > + regulator-always-on; 
> > > + regulator-min-microvolt = <2700000>; 
> > > + regulator-max-microvolt = <3300000>; 
> > > + regulator-name = "vcc-pll-avcc"; 
> > > +}; 
> > > + 
> > > +&reg_dc1sw { 
> > > + regulator-name = "vcc-phy"; 
> > > +}; 
> > > + 
> > > +&reg_dcdc1 { 
> > > + regulator-always-on; 
> > > + regulator-min-microvolt = <3300000>; 
> > > + regulator-max-microvolt = <3300000>; 
> > > + regulator-name = "vcc-3v3"; 
> > > +}; 
> > > + 
> > > +&reg_dcdc2 { 
> > > + regulator-always-on; 
> > > + regulator-min-microvolt = <1000000>; 
> > > + regulator-max-microvolt = <1300000>; 
> > > + regulator-name = "vdd-cpux"; 
> > > +}; 
> > > + 
> > > +/* DCDC3 is polyphased with DCDC2 */ 
> > > + 
> > > +&reg_dcdc5 { 
> > > + regulator-always-on; 
> > > + regulator-min-microvolt = <1500000>; 
> > > + regulator-max-microvolt = <1500000>; 
> > > + regulator-name = "vcc-dram"; 
> > > +}; 
> > > + 
> > > +&reg_dcdc6 { 
> > > + regulator-always-on; 
> > > + regulator-min-microvolt = <1100000>; 
> > > + regulator-max-microvolt = <1100000>; 
> > > + regulator-name = "vdd-sys"; 
> > > +}; 
> > > + 
> > > +&reg_dldo1 { 
> > > + regulator-min-microvolt = <3300000>; 
> > > + regulator-max-microvolt = <3300000>; 
> > > + regulator-name = "vcc-hdmi"; 
> > > +}; 
> > > + 
> > > +&reg_dldo2 { 
> > > + regulator-min-microvolt = <3300000>; 
> > > + regulator-max-microvolt = <3300000>; 
> > > + regulator-name = "vcc-mipi"; 
> > > +}; 
> > > + 
> > > +&reg_dldo3 { 
> > > + regulator-min-microvolt = <3300000>; 
> > > + regulator-max-microvolt = <3300000>; 
> > > + regulator-name = "avdd-csi"; 
> > > +}; 
> > > + 
> > > +&reg_dldo4 { 
> > > + regulator-min-microvolt = <3300000>; 
> > > + regulator-max-microvolt = <3300000>; 
> > > + regulator-name = "vcc-wifi"; 
> > > +}; 
> > > + 
> > > +&reg_eldo1 { 
> > > + regulator-min-microvolt = <1800000>; 
> > > + regulator-max-microvolt = <1800000>; 
> > > + regulator-name = "cpvdd"; 
> > > +}; 
> > > + 
> > > +&reg_eldo3 { 
> > > + regulator-min-microvolt = <1800000>; 
> > > + regulator-max-microvolt = <1800000>; 
> > > + regulator-name = "vdd-1v8-csi"; 
> > > +}; 
> > > + 
> > > +&reg_fldo1 { 
> > > + regulator-min-microvolt = <1200000>; 
> > > + regulator-max-microvolt = <1200000>; 
> > > + regulator-name = "vcc-1v2-hsic"; 
> > > +}; 
> > > + 
> > > +&reg_fldo2 { 
> > > + regulator-always-on; 
> > > + regulator-min-microvolt = <1100000>; 
> > > + regulator-max-microvolt = <1100000>; 
> > > + regulator-name = "vdd-cpus"; 
> > > +}; 
> >
> > Why do you need to always power the AR100 on? 
> 
> It's for CPUS power domain, not the AR100 processor.
> 
> Kill it will lead to instantly system hang.

What are you calling CPUS then?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/e83b0db4/attachment.sig>
