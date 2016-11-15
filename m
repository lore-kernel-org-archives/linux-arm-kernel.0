From: yuantian.tang@nxp.com (Y.T. Tang)
Date: Tue, 15 Nov 2016 07:59:59 +0000
Subject: [PATCH] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <1478715118-12848-1-git-send-email-harninder.rai@nxp.com>
References: <1478715118-12848-1-git-send-email-harninder.rai@nxp.com>
Message-ID: <VI1PR0402MB28485BC83A6E8455AC8D7C7EF0BF0@VI1PR0402MB2848.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harninder,

Please add compatible string "fsl,ls1043a-ahci" to sata node because they are compatible.
In this way, sata can be enabled.

Regards,
Yuantian 

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Harninder Rai
> Sent: Thursday, November 10, 2016 2:12 AM
> To: devicetree at vger.kernel.org; shawnguo at kernel.org;
> robh+dt at kernel.org; mark.rutland at arm.com
> Cc: oss at buserror.net; Harninder Rai <harninder.rai@nxp.com>; Bhaskar U
> <bhaskar.upadhaya@nxp.com>; linux-arm-kernel at lists.infradead.org
> Subject: [PATCH] arm64: Add DTS support for FSL's LS1012A SoC
> 
> Add the device tree support for FSL LS1012A SoC.
>     Following levels of DTSI/DTS files have been created for the LS1012A
>     SoC family:
> 
>             - fsl-ls1012a.dtsi:
>                     DTS-Include file for FSL LS1012A SoC.
> 
>             - fsl-ls1012a-frdm.dts:
>                     DTS file for FSL LS1012A FRDM board.
> 
>             - fsl-ls1012a-qds.dts:
>                     DTS file for FSL LS1012A QDS board.
> 
>             - fsl-ls1012a-rdb.dts:
>                     DTS file for FSL LS1012A RDB board.
> 
> Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 115 ++++++++++
> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 128 +++++++++++
> arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |  59 +++++
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 248
> +++++++++++++++++++++
>  5 files changed, 553 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index 6602718..39db645 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -1,3 +1,6 @@
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb diff --git
> a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> new file mode 100644
> index 0000000..1f2da79
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> @@ -0,0 +1,115 @@
> +/*
> + * Device Tree file for Freescale LS1012A Freedom Board.
> + *
> + * Copyright 2016, Freescale Semiconductor
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +/dts-v1/;
> +
> +#include "fsl-ls1012a.dtsi"
> +
> +/ {
> +	model = "LS1012A Freedom Board";
> +	compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
> +
> +	sys_mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	reg_1p8v: regulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Speaker", "Speaker Ext",
> +			"Line", "Line In Jack";
> +		simple-audio-card,routing =
> +			"MIC_IN", "Microphone Jack",
> +			"Microphone Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT",
> +			"Speaker Ext", "LINE_OUT";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			frame-master;
> +			bitclock-master;
> +			system-clock-frequency = <25000000>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	codec: sgtl5000 at a {
> +		#sound-dai-cells = <0>;
> +		compatible = "fsl,sgtl5000";
> +		reg = <0xa>;
> +		VDDA-supply = <&reg_1p8v>;
> +		VDDIO-supply = <&reg_1p8v>;
> +		clocks = <&sys_mclk>;
> +	};
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
> new file mode 100644
> index 0000000..ca680a7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
> @@ -0,0 +1,128 @@
> +/*
> + * Device Tree file for Freescale LS1012A QDS Board.
> + *
> + * Copyright 2016, Freescale Semiconductor
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +/dts-v1/;
> +
> +#include "fsl-ls1012a.dtsi"
> +
> +/ {
> +	model = "LS1012A QDS Board";
> +	compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
> +
> +	sys_mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24576000>;
> +	};
> +
> +	reg_3p3v: regulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Speaker", "Speaker Ext",
> +			"Line", "Line In Jack";
> +		simple-audio-card,routing =
> +			"MIC_IN", "Microphone Jack",
> +			"Microphone Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT",
> +			"Speaker Ext", "LINE_OUT";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			frame-master;
> +			bitclock-master;
> +			system-clock-frequency = <24576000>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	pca9547 at 77 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c at 4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x4>;
> +
> +			codec: sgtl5000 at a {
> +				#sound-dai-cells = <0>;
> +				compatible = "fsl,sgtl5000";
> +				reg = <0xa>;
> +				VDDA-supply = <&reg_3p3v>;
> +				VDDIO-supply = <&reg_3p3v>;
> +				clocks = <&sys_mclk>;
> +			};
> +		};
> +	};
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> new file mode 100644
> index 0000000..924dad6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> @@ -0,0 +1,59 @@
> +/*
> + * Device Tree file for Freescale LS1012A RDB Board.
> + *
> + * Copyright 2016, Freescale Semiconductor
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +/dts-v1/;
> +
> +#include "fsl-ls1012a.dtsi"
> +
> +/ {
> +	model = "LS1012A RDB Board";
> +	compatible = "fsl,ls1012a-rdb", "fsl,ls1012a"; };
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> new file mode 100644
> index 0000000..0bf5b64
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -0,0 +1,248 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1012A family SoC.
> + *
> + * Copyright 2016, Freescale Semiconductor
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "fsl,ls1012a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			clocks = <&clockgen 1 0>;
> +			#cooling-cells = <2>;
> +		};
> +	};
> +
> +	sysclk: sysclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sysclk";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +			     /* Physical Secure PPI */
> +		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,
> +			     /* Physical Non-Secure PPI */
> +			     <1 14 IRQ_TYPE_LEVEL_LOW>,
> +			     /* Virtual PPI */
> +			     <1 11 IRQ_TYPE_LEVEL_LOW>,
> +			     /* Hypervisor PPI */
> +			     <1 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <0 106 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	gic: interrupt-controller at 1400000 {
> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x0 0x1401000 0 0x1000>, /* GICD */
> +		      <0x0 0x1402000 0 0x2000>, /* GICC */
> +		      <0x0 0x1404000 0 0x2000>, /* GICH */
> +		      <0x0 0x1406000 0 0x2000>; /* GICV */
> +		interrupts = <1 9 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	reboot {
> +		compatible = "syscon-reboot";
> +		regmap = <&dcfg>;
> +		offset = <0xb0>;
> +		mask = <0x02>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clockgen: clocking at 1ee1000 {
> +			compatible = "fsl,ls1012a-clockgen";
> +			reg = <0x0 0x1ee1000 0x0 0x1000>;
> +			#clock-cells = <2>;
> +			clocks = <&sysclk>;
> +		};
> +
> +		scfg: scfg at 1570000 {
> +			compatible = "fsl,ls1012a-scfg", "syscon";
> +			reg = <0x0 0x1570000 0x0 0x10000>;
> +			big-endian;
> +		};
> +
> +		dcfg: dcfg at 1ee0000 {
> +			compatible = "fsl,ls1012a-dcfg",
> +				     "syscon";
> +			reg = <0x0 0x1ee0000 0x0 0x10000>;
> +			big-endian;
> +		};
> +
> +		i2c0: i2c at 2180000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2180000 0x0 0x10000>;
> +			interrupts = <0 56 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clockgen 4 0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at 2190000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2190000 0x0 0x10000>;
> +			interrupts = <0 57 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clockgen 4 0>;
> +			status = "disabled";
> +		};
> +
> +		duart0: serial at 21c0500 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x00 0x21c0500 0x0 0x100>;
> +			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 0>;
> +		};
> +
> +		duart1: serial at 21c0600 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x00 0x21c0600 0x0 0x100>;
> +			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 0>;
> +		};
> +
> +		gpio0: gpio at 2300000 {
> +			compatible = "fsl,qoriq-gpio";
> +			reg = <0x0 0x2300000 0x0 0x10000>;
> +			interrupts = <0 66 IRQ_TYPE_LEVEL_LOW>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio1: gpio at 2310000 {
> +			compatible = "fsl,qoriq-gpio";
> +			reg = <0x0 0x2310000 0x0 0x10000>;
> +			interrupts = <0 67 IRQ_TYPE_LEVEL_LOW>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		wdog0: wdog at 2ad0000 {
> +			compatible = "fsl,ls1012a-wdt",
> +				     "fsl,imx21-wdt";
> +			reg = <0x0 0x2ad0000 0x0 0x10000>;
> +			interrupts = <0 83 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clockgen 4 0>;
> +			big-endian;
> +		};
> +
> +		sai1: sai at 2b50000 {
> +			#sound-dai-cells = <0>;
> +			compatible = "fsl,vf610-sai";
> +			reg = <0x0 0x2b50000 0x0 0x10000>;
> +			interrupts = <0 148 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
> +				 <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 47>,
> +			       <&edma0 1 46>;
> +			status = "disabled";
> +		};
> +
> +		sai2: sai at 2b60000 {
> +			#sound-dai-cells = <0>;
> +			compatible = "fsl,vf610-sai";
> +			reg = <0x0 0x2b60000 0x0 0x10000>;
> +			interrupts = <0 149 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
> +				 <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 45>,
> +			       <&edma0 1 44>;
> +			status = "disabled";
> +		};
> +
> +		edma0: edma at 2c00000 {
> +			#dma-cells = <2>;
> +			compatible = "fsl,vf610-edma";
> +			reg = <0x0 0x2c00000 0x0 0x10000>,
> +			      <0x0 0x2c10000 0x0 0x10000>,
> +			      <0x0 0x2c20000 0x0 0x10000>;
> +			interrupts = <0 103 IRQ_TYPE_LEVEL_LOW>,
> +				     <0 103 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "edma-tx", "edma-err";
> +			dma-channels = <32>;
> +			big-endian;
> +			clock-names = "dmamux0", "dmamux1";
> +			clocks = <&clockgen 4 3>,
> +				 <&clockgen 4 3>;
> +		};
> +
> +		sata: sata at 3200000 {
> +			compatible = "fsl,ls1012a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>;
> +			interrupts = <0 69 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clockgen 4 0>;
> +		};
> +	};
> +};
> --
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
