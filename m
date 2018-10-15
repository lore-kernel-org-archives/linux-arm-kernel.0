From: vabhav.sharma@nxp.com (Vabhav Sharma)
Date: Mon, 15 Oct 2018 02:44:00 +0000
Subject: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
In-Reply-To: <20181008055159.GH3587@dragon>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
 <20181008055159.GH3587@dragon>
Message-ID: <VI1PR04MB4800555506B64C9E93F9ED36F3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org <linux-kernel-
> owner at vger.kernel.org> On Behalf Of Shawn Guo
> Sent: Monday, October 8, 2018 11:22 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: sudeep.holla at arm.com; oss at buserror.net; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; robh+dt at kernel.org; mark.rutland at arm.com;
> linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> mturquette at baylibre.com; sboyd at kernel.org; rjw at rjwysocki.net;
> viresh.kumar at linaro.org; linux-clk at vger.kernel.org; linux-pm at vger.kernel.org;
> linux-kernel-owner at vger.kernel.org; catalin.marinas at arm.com;
> will.deacon at arm.com; gregkh at linuxfoundation.org; arnd at arndb.de;
> kstewart at linuxfoundation.org; yamada.masahiro at socionext.com; Leo Li
> <leoyang.li@nxp.com>; linux at armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com>;
> Udit Kumar <udit.kumar@nxp.com>; Pankaj Bansal <pankaj.bansal@nxp.com>;
> Priyanka Jain <priyanka.jain@nxp.com>; Sriram Dash <sriram.dash@nxp.com>
> Subject: Re: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
> 
> On Thu, Oct 04, 2018 at 06:33:51AM +0530, Vabhav Sharma wrote:
> > LX2160A reference design board (RDB) is a high-performance computing,
> > evaluation, and development platform with LX2160A SoC.
> >
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile            |   1 +
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 100
> > ++++++++++++++++++++++
> >  2 files changed, 101 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index 86e18ad..445b72b 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-
> rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > new file mode 100644
> > index 0000000..1483071
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree file
> > +for LX2160ARDB // // Copyright 2018 NXP
> > +
> > +/dts-v1/;
> > +
> > +#include "fsl-lx2160a.dtsi"
> > +
> > +/ {
> > +	model = "NXP Layerscape LX2160ARDB";
> > +	compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	sb_3v3: regulator-fixed {
> 
> The node name should probably be named like regulator-sb3v3 or something, so
> that the pattern can be followed when we have another fixed regulator to be
> added.
Ok, Agree this is fixed 3.3 standby voltage for i2c subchannels
Updating to regulator-sb3v3 
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "fixed-3.3V";
> 
> The name should be something we can find on board schematics.
Sure, I will update SMPS name which provide fixed 3.3 stand-by voltage
> 
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +};
> > +
> > +&uart0 {
> > +	status = "okay";
> > +};
> > +
> > +&uart1 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c0 {
> 
> Please keep these labeled nodes sorted alphabetically.
Ok
> 
> > +	status = "okay";
> 
> Have a newline between properties and child node.
Sure.
> 
> > +	i2c-mux at 77 {
> > +		compatible = "nxp,pca9547";
> > +		reg = <0x77>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		i2c at 2 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x2>;
> > +
> > +			power-monitor at 40 {
> > +				compatible = "ti,ina220";
> > +				reg = <0x40>;
> > +				shunt-resistor = <1000>;
> > +			};
> > +		};
> > +
> > +		i2c at 3 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x3>;
> > +
> > +			temperature-sensor at 4c {
> > +				compatible = "nxp,sa56004";
> > +				reg = <0x4c>;
> > +				vcc-supply = <&sb_3v3>;
> > +			};
> > +
> > +			temperature-sensor at 4d {
> > +				compatible = "nxp,sa56004";
> > +				reg = <0x4d>;
> > +				vcc-supply = <&sb_3v3>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c4 {
> > +	status = "okay";
> > +
> > +	rtc at 51 {
> > +		compatible = "nxp,pcf2129";
> > +		reg = <0x51>;
> > +		// IRQ10_B
> > +		interrupts = <0 150 0x4>;
> > +		};
> 
> Bad indentation.
My mistake, Updated
> 
> Shawn
> 
> > +
> > +};
> > +
> > +&usb0 {
> > +	status = "okay";
> > +};
> > +
> > +&usb1 {
> > +	status = "okay";
> > +};
> > +
> > +&crypto {
> > +	status = "okay";
> > +};
> > --
> > 2.7.4
> >
