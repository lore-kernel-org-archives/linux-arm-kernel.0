From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 May 2017 10:56:47 +0200
Subject: [linux-sunxi] [PATCH v6 8/9] arm64: allwinner: a64: enable
 AXP803 regulators for Pine64
In-Reply-To: <4B129FD0-4AEB-4DC3-AF33-C279468BD197@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-9-icenowy@aosc.io>
 <98ae1ea8-ef08-8859-63d8-57c56a6348a6@arm.com>
 <4B129FD0-4AEB-4DC3-AF33-C279468BD197@aosc.io>
Message-ID: <20170519085647.cruo55p2662mysf7@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 04:29:01PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?5?19? GMT+08:00 ??4:27:21, Andre Przywara <andre.przywara@arm.com> ??:
> >Hi,
> >
> >On 18/05/17 08:16, Icenowy Zheng wrote:
> >> Add support of AXP803 regulators in the Pine64 device tree, in order
> >to
> >> enable many future functionalities, e.g. Wi-Fi.
> >> 
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >> Changes in v6:
> >> - Rebased on next-20170517.
> >> 
> >>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 109
> >+++++++++++++++++++++
> >>  1 file changed, 109 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> index 36001884ed33..40921bacb39c 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> @@ -118,6 +118,115 @@
> >>  	};
> >>  };
> >>  
> >> +#include "axp803.dtsi"
> >> +
> >> +&reg_aldo1 {
> >> +	regulator-min-microvolt = <2800000>;
> >> +	regulator-max-microvolt = <2800000>;
> >> +	regulator-name = "vcc-csi";
> >> +};
> >> +
> >> +&reg_aldo2 {
> >> +	regulator-always-on;
> >> +	regulator-min-microvolt = <1800000>;
> >> +	regulator-max-microvolt = <3300000>;
> >> +	regulator-name = "vcc-pl";
> >> +};
> >> +
> >> +&reg_aldo3 {
> >> +	regulator-always-on;
> >> +	regulator-min-microvolt = <2700000>;
> >> +	regulator-max-microvolt = <3300000>;
> >> +	regulator-name = "vcc-pll-avcc";
> >> +};
> >> +
> >> +&reg_dc1sw {
> >> +	regulator-name = "vcc-phy";
> >> +};
> >> +
> >> +&reg_dcdc1 {
> >> +	regulator-always-on;
> >> +	regulator-min-microvolt = <3300000>;
> >> +	regulator-max-microvolt = <3300000>;
> >> +	regulator-name = "vcc-3v3";
> >> +};
> >> +
> >> +&reg_dcdc2 {
> >> +	regulator-always-on;
> >> +	regulator-min-microvolt = <1000000>;
> >> +	regulator-max-microvolt = <1300000>;
> >> +	regulator-name = "vdd-cpux";
> >> +};
> >> +
> >> +/* DCDC3 is polyphased with DCDC2 */
> >> +
> >> +&reg_dcdc5 {
> >> +	regulator-always-on;
> >> +	regulator-min-microvolt = <1500000>;
> >> +	regulator-max-microvolt = <1500000>;
> >> +	regulator-name = "vcc-dram";
> >> +};
> >
> >I think I mentioned this before, but the Pine64 has DDR3L DRAM,
> >which is specified to run at 1.35V (1.36V with the 20mV granularity
> >of the AXP).  The reset value is even (wrongly?) configured to
> >1.24V.
> >
> >So is there any reason you set the voltage to 1.5V? Is that what
> >the BSP does? Or did you see any problems with 1.36V?
> 
> I just set it based on the schematics.
> 
> And 1.35v cannot be accurately achieved by dcdc5 and it's a problem
> whether to use 1.34v or 1.36v ;-)

1.36V seems safer.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/23b2a80b/attachment.sig>
