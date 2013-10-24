From: lisovy@gmail.com (Rostislav Lisovy)
Date: Thu, 24 Oct 2013 21:12:06 +0200
Subject: [PATCH 3/4] ARM: dts: i.MX53: dts for Voipac x53-dmm-668 module
In-Reply-To: <20131023072738.GI2839@S2101-09.ap.freescale.net>
References: <1382461643-16790-1-git-send-email-lisovy@gmail.com>
 <1382461643-16790-4-git-send-email-lisovy@gmail.com>
 <20131023072738.GI2839@S2101-09.ap.freescale.net>
Message-ID: <1382641926.16515.2.camel@lolumad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn;
Thank you for your comments.
Should I also add Voipac to
Documentation/devicetree/bindings/vendor-prefixes.txt?

Best regards;
Rostislav Lisovy


On Wed, 2013-10-23 at 15:27 +0800, Shawn Guo wrote: 
> On Tue, Oct 22, 2013 at 07:07:22PM +0200, Rostislav Lisovy wrote:
> > Enable UART1 and FEC
> 
> You have more than these two enabled.
> 
> > 
> > Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
> > 
> >  create mode 100644 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
> > new file mode 100644
> > index 0000000..04695c9
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
> > @@ -0,0 +1,195 @@
> > +/*
> > + * Copyright 2013 Rostislav Lisovy <lisovy@gmail.com>, PiKRON s.r.o.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include "imx53.dtsi"
> > +
> > +/ {
> > +	model = "Voipac i.MX53 X53-DMM-668";
> > +	compatible = "vp,imx53-dmm-668", "fsl,imx53";
> > +
> > +	memory at 0 {
> > +		device_type = "memory";
> > +		reg = <0x70000000 0x20000000>;
> > +	};
> > +
> > +	memory at 1 {
> > +		device_type = "memory";
> > +		reg = <0xb0000000 0x20000000>;
> > +	};
> 
> The 'num' in memory at num should match the first number in 'reg' property,
> so they should looks like:
> 
> 	memory at 70000000 {
> 		device_type = "memory";
> 		reg = <0x70000000 0x20000000>;
> 	}
> 
> 	memory at b0000000 {
> 		device_type = "memory";
> 		reg = <0xb0000000 0x20000000>;
> 	}
> 
> > +
> > +	regulators {
> > +		compatible = "simple-bus";
> > +
> > +		reg_3p3v: 3p3v {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "3P3V";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +	};
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_hog>;
> > +
> > +	hog {
> > +		pinctrl_hog: hoggrp {
> > +			fsl,pins = <
> > +				/* Make DA9053 regulator functional */
> > +				MX53_PAD_GPIO_16__GPIO7_11	0x80000000
> > +
> 
> Drop these blank lines.  We generally only have blank lines between
> nodes.
> 
> > +				/* FEC Power enable */
> > +				MX53_PAD_GPIO_11__GPIO4_1	0x80000000
> > +
> > +				/* FEC RST */
> > +				MX53_PAD_GPIO_12__GPIO4_2	0x80000000
> > +			>;
> > +		};
> > +	};
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart1_2>;
> > +	status = "okay";
> > +};
> > +
> > +&i2c1 {
> 
> Please sort these nodes alphabetically in label name, so that new node
> can find they slots easily.
> 
> Shawn
> 
