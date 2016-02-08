From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Feb 2016 15:29:33 +0000
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <56B8B45D.1020902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/16 09:11, Antoine Tenart wrote:
> This patch adds the initial support for the Alpine v2 EVP board from
> Annapurna Labs (Amazon).
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
> Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> ---
>  arch/arm64/boot/dts/Makefile             |   1 +
>  arch/arm64/boot/dts/al/Makefile          |   5 +
>  arch/arm64/boot/dts/al/alpine-v2-evp.dts |  46 +++++++
>  arch/arm64/boot/dts/al/alpine-v2.dtsi    | 221 +++++++++++++++++++++++++++++++
>  4 files changed, 273 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/al/Makefile
>  create mode 100644 arch/arm64/boot/dts/al/alpine-v2-evp.dts
>  create mode 100644 arch/arm64/boot/dts/al/alpine-v2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index f832b8a7453a..fd80617a9c6f 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,3 +1,4 @@
> +dts-dirs += al
>  dts-dirs += altera
>  dts-dirs += amd
>  dts-dirs += apm
> diff --git a/arch/arm64/boot/dts/al/Makefile b/arch/arm64/boot/dts/al/Makefile
> new file mode 100644
> index 000000000000..8a6cde4f9b23
> --- /dev/null
> +++ b/arch/arm64/boot/dts/al/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_ALPINE)	+= alpine-v2-evp.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/al/alpine-v2-evp.dts b/arch/arm64/boot/dts/al/alpine-v2-evp.dts
> new file mode 100644
> index 000000000000..3e3080fa45e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/al/alpine-v2-evp.dts
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +#include "alpine-v2.dtsi"
> +
> +/ {
> +	model = "Annapurna Labs Alpine v2 EVP";
> +	compatible = "al,alpine-v2-evp", "al,alpine-v2";
> +
> +	chosen {
> +		stdout-path = "console0:115200n8";
> +	};
> +};
> +
> +&uart0 { status = "okay"; };
> diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/al/alpine-v2.dtsi
> new file mode 100644
> index 000000000000..eb7a03b71456
> --- /dev/null
> +++ b/arch/arm64/boot/dts/al/alpine-v2.dtsi
> @@ -0,0 +1,221 @@
> +/*
> + * Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "Annapurna Labs Alpine v2";
> +	compatible = "al,alpine-v2";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			compatible = "arm,cortex-a57", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 1 {
> +			compatible = "arm,cortex-a57", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 2 {
> +			compatible = "arm,cortex-a57", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 3 {
> +			compatible = "arm,cortex-a57", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2", "arm,psci";
> +		method = "smc";
> +		cpu_on = <0x84000003>;
> +	};
> +
> +	sbclk: sbclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1000000>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 0xd 0xff08>,
> +				     <GIC_PPI 0xe 0xff08>,
> +				     <GIC_PPI 0xb 0xff08>,
> +				     <GIC_PPI 0xa 0xff08>;
> +		};

This is not a valid interrupt specifier for GICv3, as the 3rd field
shouldn't bear this 0xff thing.

> +		gic: gic at f0100000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
> +			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
> +			      <0x0 0xf0100000 0x0 0x2000>;	/* GICC */
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};

Something is wrong here. Either you are missing GICH and GICV (assuming
you have legacy support), or you have an extra GICC region (which
doesn't make sense on its own).

You're also missing the maintenance interrupt.

Has Anapurna really built a GICv3 without an ITS?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
