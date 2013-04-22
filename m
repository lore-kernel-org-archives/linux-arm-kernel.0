From: robherring2@gmail.com (Rob Herring)
Date: Mon, 22 Apr 2013 15:59:47 -0500
Subject: [PATCH 4/4] arm64: Add initial DTS for APM X-Gene Storm SOC and
 APM Mustang board
In-Reply-To: <1366442131-26094-5-git-send-email-vkale@apm.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <1366442131-26094-5-git-send-email-vkale@apm.com>
Message-ID: <5175A4C3.3090009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2013 02:15 AM, Vinayak Kale wrote:
> This patch adds initial DTS files required for APM Mustang board.
> 
> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  arch/arm64/boot/dts/Makefile    |    1 +
>  arch/arm64/boot/dts/mustang.dts |   28 +++++++++
>  arch/arm64/boot/dts/storm.dtsi  |  116 +++++++++++++++++++++++++++++++++++++++

Can you add "apm" to these filenames.

>  3 files changed, 145 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mustang.dts
>  create mode 100644 arch/arm64/boot/dts/storm.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 68457e9..faeab34 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
> +dtb-$(CONFIG_ARCH_XGENE) += mustang.dtb
>  
>  targets += dtbs
>  targets += $(dtb-y)
> diff --git a/arch/arm64/boot/dts/mustang.dts b/arch/arm64/boot/dts/mustang.dts
> new file mode 100644
> index 0000000..a061c99
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mustang.dts
> @@ -0,0 +1,28 @@
> +/*
> + * dts file for AppliedMicro (APM) Mustang Board
> + *
> + * Copyright (C) 2013, Applied Micro Circuits Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/include/ "storm.dtsi"
> +
> +/ {
> +	model = "mustang";
> +
> +	/* chosen */

Wow, that's a useful comment.

> +	chosen {
> +		linux,stdout-path = &serial0;

I don't think this is needed if you only have a single uart.

> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/storm.dtsi b/arch/arm64/boot/dts/storm.dtsi
> new file mode 100644
> index 0000000..8cab5d1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/storm.dtsi
> @@ -0,0 +1,116 @@
> +/*
> + * dts file for AppliedMicro (APM) X-Gene Storm SOC
> + *
> + * Copyright (C) 2013, Applied Micro Circuits Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/ {
> +	compatible = "apm,xgene,storm", "apm,xgene";

Need to add documentation for the binding and the vendor prefix if it is
not already there.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0000>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0001>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0100>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +		cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0101>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +		cpu at 4 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0200>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +		cpu at 5 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0201>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +		cpu at 6 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0300>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +		cpu at 7 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0301>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x1 0x0000fff8>;
> +		};
> +	};
> +
> +	gic: interrupt-controller at 78010000 {
> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x0 0x78010000 0x0 0x1000>,	/* GIC Dist */
> +		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
> +		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
> +		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
> +		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 0 0xff01>,	/* Secure Phys IRQ */
> +			     <1 13 0xff01>,	/* Non-secure Phys IRQ */
> +			     <1 14 0xff01>,	/* Virt IRQ */
> +			     <1 15 0xff01>;	/* Hyp IRQ */
> +		clock-frequency = <50000000>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		serial0: uart0 at 1c020000 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0 0x1c020000 0x0 0x1000>;
> +			reg-shift = <2>;
> +			clock-frequency = <10000000>; /* Updated by bootloader */
> +			interrupt-parent = <&gic>;
> +			interrupts = <0x0 0x4c 0x4>;
> +		};
> +	};
> +};
> 
