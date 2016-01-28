From: ping.bai@nxp.com (Ping Bai)
Date: Thu, 28 Jan 2016 10:43:01 +0000
Subject: [PATCH v2 2/5] ARM: dts: imx: Add basic dts support for
 imx6qp-sabresd
In-Reply-To: <20160128075408.GM9070@tiger>
References: <1450159673-27314-1-git-send-email-b51503@freescale.com>
 <1450159673-27314-3-git-send-email-b51503@freescale.com>
 <20160128075408.GM9070@tiger>
Message-ID: <DB4PR04MB53807A99AAED4F18A6B383987DA0@DB4PR04MB538.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2016?1?28? 15:54
> To: b51503 at freescale.com
> Cc: kernel at pengutronix.de; devicetree at vger.kernel.org;
> pawel.moll at arm.com; mturquette at baylibre.com; sboyd at codeaurora.org;
> robh+dt at kernel.org; linux-clk at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/5] ARM: dts: imx: Add basic dts support for imx6qp-
> sabresd
> 
> On Tue, Dec 15, 2015 at 02:07:50PM +0800, Bai Ping wrote:
> > The patch adds dts file for imx6qp-sabresd board.
> >
> > Signed-off-by: Bai Ping <b51503@freescale.com>
> > ---
> >  arch/arm/boot/dts/Makefile             |  1 +
> >  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |  1 +
> >  arch/arm/boot/dts/imx6qp-sabresd.dts   | 59
> ++++++++++++++++++++++++++++++++++
> >  3 files changed, 61 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6qp-sabresd.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 36d8133..dfba765 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -302,6 +302,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
> >  	imx6dl-sabreauto.dtb \
> >  	imx6dl-sabrelite.dtb \
> >  	imx6dl-sabresd.dtb \
> > +	imx6qp-sabresd.dtb \
> 
> Please keep the list sort alphabetically.  That said, imx6qp-sabresd.dtb should
> be added after imx6q-* ones.
> 
> >  	imx6dl-tx6dl-comtft.dtb \
> >  	imx6dl-tx6u-801x.dtb \
> >  	imx6dl-tx6u-811x.dtb \
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > index a6d445c..f65f57b 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > @@ -238,6 +238,7 @@
> >  				regulator-max-microvolt = <3300000>;
> >  				regulator-boot-on;
> >  				regulator-always-on;
> > +				regulator-ramp-delay = <6250>;
> 
> So this change applies to imx6q and imx6dl sabresd as well?
> 

Yes, this change applies to imx6q and imx6dl sabresd.

> >  			};
> >
> >  			sw3a_reg: sw3a {
> > diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts
> > b/arch/arm/boot/dts/imx6qp-sabresd.dts
> > new file mode 100644
> > index 0000000..c3ab2b6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
> > @@ -0,0 +1,59 @@
> > +/*
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include "imx6q-sabresd.dts"
> > +#include "imx6qp.dtsi"
> 
> Ah, that's why you do not include "imx6qdl.dtsi" in imx6qp.dtsi.  I have a
> question with this approach.  How people should write his imx6qp board dts file,
> if his board never has an imx6q version?
> 
 
Sure, it is a problem, include the imx6qdl.dtsi in imx6qp.dtsi is more reasonable.

> > +
> > +/ {
> > +	model = "Freescale i.MX6 Quad Plus SABRE Smart Device Board";
> > +	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp"; };
> > +
> > +&cpu0 {
> > +	arm-supply = <&sw2_reg>;
> > +};
> > +
> > +&iomuxc {
> > +	imx6qdl-sabresd {
> 
> Since commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without function
> nodes), this additional container node can just be saved.
> 
> Shawn
> 
> > +		pinctrl_usdhc2: usdhc2grp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_SD2_CMD__SD2_CMD
> 	0x17059
> > +				MX6QDL_PAD_SD2_CLK__SD2_CLK
> 	0x10071
> > +				MX6QDL_PAD_SD2_DAT0__SD2_DATA0
> 	0x17059
> > +				MX6QDL_PAD_SD2_DAT1__SD2_DATA1
> 	0x17059
> > +				MX6QDL_PAD_SD2_DAT2__SD2_DATA2
> 	0x17059
> > +				MX6QDL_PAD_SD2_DAT3__SD2_DATA3
> 	0x17059
> > +				MX6QDL_PAD_NANDF_D4__SD2_DATA4
> 	0x17059
> > +				MX6QDL_PAD_NANDF_D5__SD2_DATA5
> 	0x17059
> > +				MX6QDL_PAD_NANDF_D6__SD2_DATA6
> 	0x17059
> > +				MX6QDL_PAD_NANDF_D7__SD2_DATA7
> 	0x17059
> > +			>;
> > +		};
> > +
> > +		pinctrl_usdhc3: usdhc3grp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_SD3_CMD__SD3_CMD
> 	0x17059
> > +				MX6QDL_PAD_SD3_CLK__SD3_CLK
> 	0x10071
> > +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0
> 	0x17059
> > +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1
> 	0x17059
> > +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2
> 	0x17059
> > +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3
> 	0x17059
> > +				MX6QDL_PAD_SD3_DAT4__SD3_DATA4
> 	0x17059
> > +				MX6QDL_PAD_SD3_DAT5__SD3_DATA5
> 	0x17059
> > +				MX6QDL_PAD_SD3_DAT6__SD3_DATA6
> 	0x17059
> > +				MX6QDL_PAD_SD3_DAT7__SD3_DATA7
> 	0x17059
> > +			>;
> > +		};
> > +	};
> > +};
> > +
> > +&pcie {
> > +	power-on-gpio = <&gpio3 19 0>;
> > +	reset-gpio = <&gpio7 12 0>;
> > +	status = "okay";
> > +};
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
