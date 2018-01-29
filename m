From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 29 Jan 2018 13:43:52 +0530
Subject: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180126221501.GD28313@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180126221501.GD28313@codeaurora.org>
Message-ID: <514c49cc-71f9-ee21-250a-04f8fab151c0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/27/2018 03:45 AM, Stephen Boyd wrote:
> On 01/25, Rajendra Nayak wrote:
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
> 
> Do we really need two files? Maybe collapse the two?

will do. Not sure why, but this is how all other qualcomm
boards are structured with an almost empty .dts file.

> 
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> new file mode 100644
>> index 000000000000..a21f4912b3e2
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -0,0 +1,308 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. SDM845";
>> +
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	chosen { };
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the reg */
>> +		reg = <0 0 0 0>;
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +			L2_0: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +				L3_0: l3-cache {
>> +				      compatible = "cache";
>> +				};
>> +			};
>> +		};
>> +
>> +		CPU1: cpu at 100 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x100>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_100>;
>> +			L2_100: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU2: cpu at 200 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x200>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_200>;
>> +			L2_200: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU3: cpu at 300 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x300>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_300>;
>> +			L2_300: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU4: cpu at 400 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x400>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_400>;
>> +			L2_400: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU5: cpu at 500 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x500>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_500>;
>> +			L2_500: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU6: cpu at 600 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x600>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_600>;
>> +			L2_600: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU7: cpu at 700 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
>> +			reg = <0x0 0x700>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_700>;
>> +			L2_700: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&CPU0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&CPU1>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&CPU2>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&CPU3>;
>> +				};
>> +			};
>> +
>> +			cluster1 {
>> +				core0 {
>> +					cpu = <&CPU4>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&CPU5>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&CPU6>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&CPU7>;
>> +				};
>> +			};
>> +		};
> 
> From what I recall, this layout causes the kernel to spew
> warnings? I mean to say this is the power/performance view, but
> not the architectural view.

hmm, I haven't seen any warnings with this when I boot up on my sdm845
MTP. Will recheck.

> 
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> 
> Are we supposed to use the GIC_CPU_MASK_SIMPLE macros still?

Not sure, is there another way?

> 
>> +			     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	clocks {
>> +		xo_board: xo_board {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <19200000>;
>> +			clock-output-names = "xo_board";
> 
> We can drop clock-output-names on these.

will do.

> 
>> +		};
>> +
>> +		sleep_clk: sleep_clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32764>;
>> +			clock-output-names = "sleep_clk";
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +	};
>> +
>> +	soc: soc {
> 
> Will anyone use this phandle?

maybe not, will drop.

> 
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +		compatible = "simple-bus";
>> +
>> +		intc: interrupt-controller at 17a00000 {
>> +			compatible = "arm,gic-v3";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x20000>;
>> +			reg = <0x17a00000 0x10000>,     /* GICD */
>> +			      <0x17a60000 0x100000>;    /* GICR * 8 */
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> 
> Can you also add the ITS node please and mark it as disabled?
> I'll send a patch to the list to skip status = "disabled" ones.
> We may want to support ITS on these SoCs if the firmware is
> different. 

will add.

> 
>> +		};
>> +
>> +		gcc: clock-controller at 100000 {
>> +			compatible = "qcom,gcc-sdm845";
>> +			reg = <0x100000 0x1f0000>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		tlmm: pinctrl at 03400000 {
> 
> Drop leading zeroes please.
> 
>> +			compatible = "qcom,sdm845-pinctrl";
>> +			reg = <0x03400000 0xc00000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +
>> +		timer at 17C90000 {
> 
> Lowercase hex please.
> 
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0x17C90000 0x1000>;
> 
> Lowercase hex please.
> 
>> +			clock-frequency = <19200000>;
> 
> Drop this? Or we can't read it from the hardware so we have to
> hardcode it?

will drop, shouldn't be needed.

> 
>> +
>> +			frame at 17CA0000 {
> 
> Lowecase again.
> 
>> +				frame-number = <0>;
>> +				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17CA0000 0x1000>,
>> +				      <0x17CB0000 0x1000>;
>> +			};
>> +
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
