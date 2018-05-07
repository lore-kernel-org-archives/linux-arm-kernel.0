From: swboyd@chromium.org (Stephen Boyd)
Date: Mon, 07 May 2018 15:59:56 -0700
Subject: [PATCH v2 1/2] arm64: dts: Add msm8998 SoC and MTP board support
In-Reply-To: <20180428054248.22387-1-bjorn.andersson@linaro.org>
References: <20180428054248.22387-1-bjorn.andersson@linaro.org>
Message-ID: <152573399648.138124.10341359049104453178@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bjorn Andersson (2018-04-27 22:42:47)
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> new file mode 100644
> index 000000000000..d6665e4f801f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8998.h>
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. MSM 8998";
> +
> +       interrupt-parent = <&intc>;
> +
> +       qcom,msm-id = <292 0x0>;

No update to dtbtool?

> +
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       chosen { };
> +
> +       memory {
> +               device_type = "memory";
> +               /* We expect the bootloader to fill in the reg */
> +               reg = <0 0 0 0>;
> +       };
> +
> +       cpus {
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               CPU0: cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x0>;
> +                       enable-method = "psci";
> +                       efficiency = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       L2_0: l2-cache {
> +                               compatible = "arm,arch-cache";
> +                               cache-level = <2>;
> +                       };
> +                       L1_I_0: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_0: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               CPU1: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x1>;
> +                       enable-method = "psci";
> +                       efficiency = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       L1_I_1: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_1: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               CPU2: cpu at 2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x2>;
> +                       enable-method = "psci";
> +                       efficiency = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       L1_I_2: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_2: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               CPU3: cpu at 3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x3>;
> +                       enable-method = "psci";
> +                       efficiency = <1024>;
> +                       next-level-cache = <&L2_0>;
> +                       L1_I_3: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_3: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               CPU4: cpu at 100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x100>;
> +                       enable-method = "psci";
> +                       efficiency = <1536>;
> +                       next-level-cache = <&L2_1>;
> +                       L2_1: l2-cache {
> +                               compatible = "arm,arch-cache";
> +                               cache-level = <2>;
> +                       };
> +                       L1_I_100: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_100: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               CPU5: cpu at 101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x101>;
> +                       enable-method = "psci";
> +                       efficiency = <1536>;
> +                       next-level-cache = <&L2_1>;
> +                       L1_I_101: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_101: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               CPU6: cpu at 102 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x102>;
> +                       enable-method = "psci";
> +                       efficiency = <1536>;
> +                       next-level-cache = <&L2_1>;
> +                       L1_I_102: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_102: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               CPU7: cpu at 103 {
> +                       device_type = "cpu";
> +                       compatible = "arm,armv8";
> +                       reg = <0x0 0x103>;
> +                       enable-method = "psci";
> +                       efficiency = <1536>;
> +                       next-level-cache = <&L2_1>;
> +                       L1_I_103: l1-icache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +                       L1_D_103: l1-dcache {
> +                               compatible = "arm,arch-cache";
> +                       };
> +               };
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&CPU0>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&CPU1>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&CPU2>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&CPU3>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu = <&CPU4>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&CPU5>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&CPU6>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&CPU7>;
> +                               };
> +                       };
> +               };

I still wonder if this is accurate, but OK.

> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> +                            <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> +                            <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> +                            <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       clocks {
> +               xo_board {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <19200000>;
> +               };
> +
> +               sleep_clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <32764>;
> +               };
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       soc: soc {};
> +};
> +
> +&soc {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       ranges = <0 0 0 0xffffffff>;
> +       compatible = "simple-bus";
> +
> +       intc: interrupt-controller at 17a00000 {
> +               compatible = "arm,gic-v3";
> +               reg = <0x17a00000 0x10000>,       /* GICD */
> +                     <0x17b00000 0x100000>;      /* GICR * 8 */
> +               #interrupt-cells = <3>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               interrupt-controller;
> +               #redistributor-regions = <1>;
> +               redistributor-stride = <0x0 0x20000>;

Is this needed? The redistributor stuff can be left out if there's only
one right?

> +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       blsp2_uart1: serial at c1b0000 {

Clk name says uart2 though?

> +               compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +               reg = <0xc1b0000 0x1000>;
> +               interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
> +                        <&gcc GCC_BLSP2_AHB_CLK>;
> +               clock-names = "core", "iface";
> +               status = "disabled";
> +       };
> +
