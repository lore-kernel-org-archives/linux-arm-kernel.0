From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Fri, 22 Jul 2016 15:32:56 +0000
Subject: [PATCH] [linux-devel]arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <1469165712-4356-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1469165712-4356-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <VI1PR0401MB2638B8CD4975FFCADC489E398D0A0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Bhaskar Upadhaya [mailto:Bhaskar.Upadhaya at nxp.com]
> Sent: Friday, July 22, 2016 12:35 AM
> To: devicetree at vger.kernel.org; shawnguo at kernel.org
> Cc: Stuart Yoder <stuart.yoder@nxp.com>; oss at buserror.net; linux-arm-kernel at lists.infradead.org; Bhaskar
> U <bhaskar.upadhaya@nxp.com>; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Calvin Johnson
> <calvin.johnson@nxp.com>; Makarand Pawagi <makarand.pawagi@nxp.com>; Pratiyush Srivastava
> <pratiyush.srivastava@nxp.com>; Yunhui Cui <yunhui.cui@nxp.com>; Rajesh Bhagat <rajesh.bhagat@nxp.com>;
> Huan Wang <alison.wang@nxp.com>; Hongtao Jia <hongtao.jia@nxp.com>; Anji J
> <anji.jagarlmudi@freescale.com>
> Subject: [PATCH] [linux-devel]arm64: Add DTS support for FSL's LS1012A SoC
> 
> The QorIQ LS1012A processor is a new Freescale' SoC optimized
> for battery-backed or USB-powered, integrates a single ARM
> Cortex-A53 core with a hardware packet forwarding engine
> and high-speed interfaces to deliver line-rate networking performance.
> LS1012AQDS, LS1012ARDB, LS1012AFRDM are a high-performance development platform
> using LS1012A SoC.

A patch description should not read like a marketing brochure.  Delete the
above text.

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-
> ls1012a-frdm.dts
> new file mode 100644
> index 0000000..5db6133
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> @@ -0,0 +1,186 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1012A family SoC.

Why are you calling this an "Include file" when it is not?

> + * Copyright 2016, Freescale Semiconductor Inc.
> +
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */

The above license text is not consistent with other NXP/Freescale dts
files.

> +/dts-v1/;
> +
> +#include "fsl-ls1012a.dtsi"
> +
> +/ {
> +	model = "LS1012A FREEDOM Board";

Why is FREEDOM all caps?  In the marketing information on this board
it is simpley "Freedom".

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-
> ls1012a-qds.dts
> new file mode 100644
> index 0000000..40c85b7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
> @@ -0,0 +1,218 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1012A family SoC.

This is not an include file.

Also, make the license text consistent with other NXP/Freescale dts
files.

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-
> ls1012a-rdb.dts
> new file mode 100644
> index 0000000..eadcb63
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> @@ -0,0 +1,115 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1012A family SoC.

This is not an include file.

Also, make the license text consistent with other NXP/Freescale dts
files.

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-
> ls1012a.dtsi
> new file mode 100644
> index 0000000..c5fce10
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -0,0 +1,512 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1043A family SoC.

This is not an LS1043A.

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
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	compatible = "fsl,ls1012a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		/*
> +		 * We expect the enable-method for cpu's to be "psci", but this
> +		 * is dependent on the SoC FW, which will fill this in.
> +		 *
> +		 * Currently supported enable-method is psci v0.2
> +		 */
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x0>;
> +			clocks = <&clockgen 1 0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +	};
> +
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
> +		interrupts = <1 13 0x1>, /* Physical Secure PPI */
> +			     <1 14 0x1>, /* Physical Non-Secure PPI */
> +			     <1 11 0x1>, /* Virtual PPI */
> +			     <1 10 0x1>; /* Hypervisor PPI */
> +		arm,reread-timer;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <0 106 0x4>;
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
> +		interrupts = <1 9 0xf08>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clockgen: clocking at 1ee1000 {
> +			compatible = "fsl,ls1012a-clockgen","fsl,ls1043a-clockgen";
> +			reg = <0x0 0x1ee1000 0x0 0x1000>;
> +			#clock-cells = <2>;
> +			clocks = <&sysclk>;
> +		};
> +
> +		scfg: scfg at 1570000 {
> +			compatible = "fsl,ls1012a-scfg", "fsl,ls1043a-scfg", "syscon";
> +			reg = <0x0 0x1570000 0x0 0x10000>;
> +			big-endian;
> +		};
> +
> +		crypto: crypto at 1700000 {
> +			compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
> +				     "fsl,sec-v4.0";
> +			fsl,sec-era = <8>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x00 0x1700000 0x100000>;
> +			reg = <0x00 0x1700000 0x0 0x100000>;
> +			interrupts = <0 75 0x4>;
> +
> +			sec_jr0: jr at 10000 {
> +				compatible = "fsl,sec-v5.4-job-ring",
> +					     "fsl,sec-v5.0-job-ring",
> +					     "fsl,sec-v4.0-job-ring";
> +				reg	   = <0x10000 0x10000>;
> +				interrupts = <0 71 0x4>;
> +			};
> +
> +			sec_jr1: jr at 20000 {
> +				compatible = "fsl,sec-v5.4-job-ring",
> +					     "fsl,sec-v5.0-job-ring",
> +					     "fsl,sec-v4.0-job-ring";
> +				reg	   = <0x20000 0x10000>;
> +				interrupts = <0 72 0x4>;
> +			};
> +
> +			sec_jr2: jr at 30000 {
> +				compatible = "fsl,sec-v5.4-job-ring",
> +					     "fsl,sec-v5.0-job-ring",
> +					     "fsl,sec-v4.0-job-ring";
> +				reg	   = <0x30000 0x10000>;
> +				interrupts = <0 73 0x4>;
> +			};
> +
> +			sec_jr3: jr at 40000 {
> +				compatible = "fsl,sec-v5.4-job-ring",
> +					     "fsl,sec-v5.0-job-ring",
> +					     "fsl,sec-v4.0-job-ring";
> +				reg	   = <0x40000 0x10000>;
> +				interrupts = <0 74 0x4>;
> +			};
> +		};
> +
> +
> +		dcfg: dcfg at 1ee0000 {
> +			compatible = "fsl,ls1012a-dcfg", "fsl,ls1043a-dcfg", "syscon";
> +			reg = <0x0 0x1ee0000 0x0 0x10000>;
> +		};
> +
> +		reset: reset at 1EE00B0 {
> +			compatible = "fsl,ls-reset";
> +			reg = <0x0 0x1EE00B0 0x0 0x4>;
> +			big-endian;
> +		};

Where is the binding for the above node?  Other arm64 SoCs are using
"syscon-reboot".  Can that be used?


> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		pfe_reserved: packetbuffer at 83400000 {
> +			reg = <0 0x83400000 0 0xc00000>;
> +		};
> +	};
> +
> +	pfe: pfe at 04000000 {
> +		compatible = "fsl,pfe";
> +		ranges = <0x0 0x00 0x04000000 0xc00000
> +			  0x1 0x00 0x83400000 0xc00000>;
> +		reg =   <0x0 0x90500000 0x0 0x10000>,	/* APB 64K */
> +			<0x0 0x04000000 0x0 0xc00000>,	/* AXI 16M */
> +			<0x0 0x83400000 0x0 0xc00000>,    /* PFE DDR 12M */
> +			<0x0 0x10000000 0x0 0x2000>;	/* OCRAM 8K  */
> +		fsl,pfe-num-interfaces = < 0x2 >;
> +		interrupts = <0 172 0x4>;
> +		#interrupt-names = "hifirq";
> +		memory-region = <&pfe_reserved>;
> +		fsl,pfe-scfg = <&scfg 0>;
> +	};

I understand the PFE driver needs some memory, but I think
the way you are doing it needs to be completely re-thought
through.  Where is the magic 0x83400000 coming from?  Why
does that address show up in 2 places-- both the pfe reg
property and the reserved-memory node?

Stuart
