From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 09 May 2014 10:06:36 +0900
Subject: [PATCHv4 7/7] ARM: dts: Add device tree sources for Exynos3250
In-Reply-To: <535B0324.50705@gmail.com>
References: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
 <1398388572-30239-8-git-send-email-cw00.choi@samsung.com>
 <535B0324.50705@gmail.com>
Message-ID: <536C2A1C.6030807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 04/26/2014 09:51 AM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 25.04.2014 03:16, Chanwoo Choi wrote:
>> From: Tomasz Figa <t.figa@samsung.com>
>>
>> This patch add new exynos3250.dtsi to support Exynos3250 SoC based on Cortex-A7
>> dual core and includes following dt nodes:
>>
>> - GIC interrupt controller
>> - Pinctrl to control GPIOs
>> - Clock controller
>> - CPU information (Cortex-A7 dual core)
>> - UART to support serial port
>> - MCT (Multi Core Timer)
>> - ADC (Analog Digital Converter)
>> - I2C/SPI bus
>> - Power domain
>> - PMU (Performance Monitoring Unit)
>> - MSHC (Mobile Storage Host Controller)
>> - PWM (Pluse Width Modulation)
>> - AMBA bus
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: devicetree at vger.kernel.org
>> ---
>>   arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 477 +++++++++++++++
>>   arch/arm/boot/dts/exynos3250.dtsi         | 405 +++++++++++++
>>   arch/arm/boot/dts/exynos4212-tizenw.dts   | 926 ++++++++++++++++++++++++++++++
>>   3 files changed, 1808 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/exynos3250-pinctrl.dtsi
>>   create mode 100644 arch/arm/boot/dts/exynos3250.dtsi
>>   create mode 100644 arch/arm/boot/dts/exynos4212-tizenw.dts
>>
>> diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
>> new file mode 100644
>> index 0000000..976490b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
>> @@ -0,0 +1,477 @@
>> +/*
>> + * Samsung's Exynos3250 SoCs pin-mux and pin-config device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *        http://www.samsung.com
>> + *
>> + * Samsung's Exynos3250 SoCs pin-mux and pin-config optiosn are listed as device
>> + * tree nodes are listed in this file.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/ {
>> +    pinctrl at 11400000 {
> 
> Could you use references instead of re-specifying the whole tree hierarchy in every file a node is used?
> 
> Instead of
> 
> / {
>     pinctrl at 11400000 {
> 
>     };
> };
> 
> one may simply use
> 
> &pinctrl_0 {
> 
> };
> 
> You might just need to change the location of #include "exynos3250-pinctrl.dtsi" from top of exynos3250.dtsi to bottom of it.
> 

OK, I'll change it.

>> +        gpa0: gpa0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpa1: gpa1 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpb: gpb {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpc0: gpc0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpc1: gpc1 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpd0: gpd0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpd1: gpd1 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        uart0_data: uart0-data {
>> +            samsung,pins = "gpa0-0", "gpa0-1";
>> +            samsung,pin-function = <0x2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        uart0_fctl: uart0-fctl {
>> +            samsung,pins = "gpa0-2", "gpa0-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        uart1_data: uart1-data {
>> +            samsung,pins = "gpa0-4", "gpa0-5";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        uart1_fctl: uart1-fctl {
>> +            samsung,pins = "gpa0-6", "gpa0-7";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c2_bus: i2c2-bus {
>> +            samsung,pins = "gpa0-6", "gpa0-7";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c3_bus: i2c3-bus {
>> +            samsung,pins = "gpa1-2", "gpa1-3";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        spi0_bus: spi0-bus {
>> +            samsung,pins = "gpb-0", "gpb-2", "gpb-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c4_bus: i2c4-bus {
>> +            samsung,pins = "gpb-0", "gpb-1";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        spi1_bus: spi1-bus {
>> +            samsung,pins = "gpb-4", "gpb-6", "gpb-7";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c5_bus: i2c5-bus {
>> +            samsung,pins = "gpb-2", "gpb-3";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2s2_bus: i2s2-bus {
>> +            samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
>> +                    "gpc1-4";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        pcm2_bus: pcm2-bus {
>> +            samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
>> +                    "gpc1-4";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c6_bus: i2c6-bus {
>> +            samsung,pins = "gpc1-3", "gpc1-4";
>> +            samsung,pin-function = <4>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        pwm0_out: pwm0-out {
>> +            samsung,pins = "gpd0-0";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        pwm1_out: pwm1-out {
>> +            samsung,pins = "gpd0-1";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c7_bus: i2c7-bus {
>> +            samsung,pins = "gpd0-2", "gpd0-3";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        pwm2_out: pwm2-out {
>> +            samsung,pins = "gpd0-2";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        pwm3_out: pwm3-out {
>> +            samsung,pins = "gpd0-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c0_bus: i2c0-bus {
>> +            samsung,pins = "gpd1-0", "gpd1-1";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        mipi0_clk: mipi0-clk {
>> +            samsung,pins = "gpd1-0", "gpd1-1";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        i2c1_bus: i2c1-bus {
>> +            samsung,pins = "gpd1-2", "gpd1-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +    };
>> +
>> +    pinctrl at 11000000 {
>> +        gpe0: gpe0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +        };
>> +
>> +        gpe1: gpe1 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +        };
>> +
>> +        gpe2: gpe2 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +        };
>> +
>> +        gpk0: gpk0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpk1: gpk1 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpk2: gpk2 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpl0: gpl0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpm0: gpm0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpm1: gpm1 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpm2: gpm2 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpm3: gpm3 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpm4: gpm4 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpx0: gpx0 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            interrupt-parent = <&gic>;
>> +            interrupts = <0 32 0>, <0 33 0>, <0 34 0>, <0 35 0>,
>> +                    <0 36 0>, <0 37 0>, <0 38 0>, <0 39 0>;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpx1: gpx1 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            interrupt-parent = <&gic>;
>> +            interrupts = <0 40 0>, <0 41 0>, <0 42 0>, <0 43 0>,
>> +                    <0 44 0>, <0 45 0>, <0 46 0>, <0 47 0>;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpx2: gpx2 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        gpx3: gpx3 {
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        sd0_clk: sd0-clk {
>> +            samsung,pins = "gpk0-0";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd0_cmd: sd0-cmd {
>> +            samsung,pins = "gpk0-1";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd0_cd: sd0-cd {
>> +            samsung,pins = "gpk0-2";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd0_rdqs: sd0-rdqs {
>> +            samsung,pins = "gpk0-7";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd0_bus1: sd0-bus-width1 {
>> +            samsung,pins = "gpk0-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd0_bus4: sd0-bus-width4 {
>> +            samsung,pins = "gpk0-4", "gpk0-5", "gpk0-6";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd0_bus8: sd0-bus-width8 {
>> +            samsung,pins = "gpl0-0", "gpl0-1", "gpl0-2", "gpl0-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd1_clk: sd1-clk {
>> +            samsung,pins = "gpk1-0";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd1_cmd: sd1-cmd {
>> +            samsung,pins = "gpk1-1";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd1_cd: sd1-cd {
>> +            samsung,pins = "gpk1-2";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd1_bus1: sd1-bus-width1 {
>> +            samsung,pins = "gpk1-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        sd1_bus4: sd1-bus-width4 {
>> +            samsung,pins = "gpk1-4", "gpk1-5", "gpk1-6";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        cam_port_b_io: cam-port-b-io {
>> +            samsung,pins = "gpm0-0", "gpm0-1", "gpm0-2", "gpm0-3",
>> +                    "gpm0-4", "gpm0-5", "gpm0-6", "gpm0-7",
>> +                    "gpm1-0", "gpm1-1", "gpm2-0", "gpm2-1";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <3>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        cam_port_b_clk_active: cam-port-b-clk-active {
>> +            samsung,pins = "gpm2-2";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <3>;
>> +        };
>> +
>> +        cam_port_b_clk_idle: cam-port-b-clk-idle {
>> +            samsung,pins = "gpm2-2";
>> +            samsung,pin-function = <0>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        fimc_is_i2c0: fimc-is-i2c0 {
>> +            samsung,pins = "gpm4-0", "gpm4-1";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        fimc_is_i2c1: fimc-is-i2c1 {
>> +            samsung,pins = "gpm4-2", "gpm4-3";
>> +            samsung,pin-function = <2>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +
>> +        fimc_is_uart: fimc-is-uart {
>> +            samsung,pins = "gpm3-5", "gpm3-7";
>> +            samsung,pin-function = <3>;
>> +            samsung,pin-pud = <0>;
>> +            samsung,pin-drv = <0>;
>> +        };
>> +    };
>> +};
>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>> new file mode 100644
>> index 0000000..5be3dd3
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>> @@ -0,0 +1,405 @@
>> +/*
>> + * Samsung's Exynos3250 SoC device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *        http://www.samsung.com
>> + *
>> + * Samsung's Exynos3250 SoC device nodes are listed in this file. Exynos3250
>> + * based board files can include this file and provide values for board specfic
>> + * bindings.
>> + *
>> + * Note: This file does not include device nodes for all the controllers in
>> + * Exynos3250 SoC. As device tree coverage for Exynos3250 increases, additional
>> + * nodes can be added to this file.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "skeleton.dtsi"
>> +#include "exynos3250-pinctrl.dtsi"
>> +#include <dt-bindings/clock/exynos3250.h>
>> +
>> +/ {
>> +    compatible = "samsung,exynos3250";
>> +    interrupt-parent = <&gic>;
>> +
>> +    aliases {
>> +        pinctrl0 = &pinctrl_0;
>> +        pinctrl1 = &pinctrl_1;
>> +        mshc0 = &mshc_0;
>> +        mshc1 = &mshc_1;
>> +        spi0 = &spi_0;
>> +        spi1 = &spi_1;
>> +        i2c0 = &i2c_0;
>> +        i2c1 = &i2c_1;
>> +        i2c2 = &i2c_2;
>> +        i2c3 = &i2c_3;
>> +        i2c4 = &i2c_4;
>> +        i2c5 = &i2c_5;
>> +        i2c6 = &i2c_6;
>> +        i2c7 = &i2c_7;
>> +    };
>> +
>> +    cpus {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        cpu at 0 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a7";
>> +            reg = <0>;
>> +            clock-frequency = <1000000000>;
>> +        };
> 
> Why only one CPU? I believe Exynos3250 is dual core. 

I'll add cpu1 information.

> Also are physical IDs of the cores really 0 and 1? On Exynos4210 for example they are 0x900 and 0x901, while on Exynos4212 they are 0xa00 and 0xa01. Please check this.

The 'reg' property means only hardware id(hwid) of CPU.
You can check it on arm_dt_init_cpu_maps() in arch/arm/kernel/devtree.c.h.
or Documentation/devicetree/bindings/arm/cpus.txt.

>> +    };
>> +
>> +    fixed-rate-clocks {
>> +        compatible = "simple-bus";
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        xusbxti: clock at 0 {
>> +            compatible = "fixed-clock";
>> +            reg = <0>;
>> +            clock-frequency = <0>;
>> +            #clock-cells = <0>;
>> +            clock-output-names = "xusbxti";
>> +        };
>> +
>> +        xxti: clock at 1 {
>> +            compatible = "fixed-clock";
>> +            reg = <1>;
>> +            clock-frequency = <0>;
>> +            #clock-cells = <0>;
>> +            clock-output-names = "xxti";
>> +        };
>> +
>> +        xtcxo: clock at 2 {
>> +            compatible = "fixed-clock";
>> +            reg = <2>;
>> +            clock-frequency = <0>;
>> +            #clock-cells = <0>;
>> +            clock-output-names = "xtcxo";
>> +        };
>> +    };
>> +
>> +    chipid at 10000000 {
>> +        compatible = "samsung,exynos4210-chipid";
>> +        reg = <0x10000000 0x100>;
>> +    };
>> +
>> +    sys_reg: syscon at 10010000 {
>> +        compatible = "samsung,exynos3-sysreg", "syscon";
>> +        reg = <0x10010000 0x400>;
>> +    };
>> +
>> +    pd_cam: cam-power-domain at 10023C00 {
>> +        compatible = "samsung,exynos4210-pd";
>> +        reg = <0x10023C00 0x20>;
>> +    };
>> +
>> +    pd_mfc: mfc-power-domain at 10023C40 {
>> +        compatible = "samsung,exynos4210-pd";
>> +        reg = <0x10023C40 0x20>;
>> +    };
>> +
>> +    pd_g3d: g3d-power-domain at 10023C60 {
>> +        compatible = "samsung,exynos4210-pd";
>> +        reg = <0x10023C60 0x20>;
>> +    };
>> +
>> +    pd_lcd0: lcd0-power-domain at 10023C80 {
>> +        compatible = "samsung,exynos4210-pd";
>> +        reg = <0x10023C80 0x20>;
>> +    };
>> +
>> +    pd_isp: isp-power-domain at 10023CA0 {
>> +        compatible = "samsung,exynos4210-pd";
>> +        reg = <0x10023CA0 0x20>;
>> +    };
>> +
>> +    cmu: clock-controller at 10030000 {
>> +        compatible = "samsung,exynos3250-cmu";
>> +        reg = <0x10030000 0x20000>;
>> +        #clock-cells = <1>;
>> +    };
>> +
>> +    rtc at 10070000 {
> 
> Please add label to the node, so it can be referenced from board dts files added later (using the method I explained above).

OK, I'll add lable as following:

	rtc_0: rtc at 10070000 {

> 
>> +        compatible = "samsung,s3c6410-rtc";
>> +        reg = <0x10070000 0x100>;
>> +        interrupts = <0 73 0>, <0 74 0>;
>> +        status = "disabled";
>> +    };
>> +
>> +    gic: interrupt-controller at 10481000 {
>> +        compatible = "arm,cortex-a15-gic";
>> +        #interrupt-cells = <3>;
>> +        interrupt-controller;
>> +        reg = <0x10481000 0x1000>,
>> +              <0x10482000 0x1000>,
>> +              <0x10484000 0x2000>,
>> +              <0x10486000 0x2000>;
>> +              interrupts = <1 9 0xf04>;
>> +    };
>> +
>> +    mct at 10050000 {
>> +        compatible = "samsung,exynos4210-mct";
>> +        reg = <0x10050000 0x800>;
>> +        interrupts = <0 218 0>, <0 219 0>, <0 220 0>, <0 221 0>,
>> +                 <0 223 0>, <0 226 0>, <0 227 0>, <0 228 0>;
>> +        clocks = <&cmu CLK_FIN_PLL>, <&cmu CLK_MCT>;
>> +        clock-names = "fin_pll", "mct";
>> +    };
>> +
>> +    pinctrl_1: pinctrl at 11000000 {
>> +        compatible = "samsung,exynos3250-pinctrl";
>> +        reg = <0x11000000 0x1000>;
>> +        interrupts = <0 225 0>;
>> +
>> +        wakeup-interrupt-controller {
>> +            compatible = "samsung,exynos4210-wakeup-eint";
>> +            interrupt-parent = <&gic>;
>> +            interrupts = <0 48 0>;
>> +        };
>> +    };
>> +
>> +    pinctrl_0: pinctrl at 11400000 {
>> +        compatible = "samsung,exynos3250-pinctrl";
>> +        reg = <0x11400000 0x1000>;
>> +        interrupts = <0 240 0>;
>> +    };
>> +
>> +    mshc_0: mshc at 12510000 {
>> +        compatible = "samsung,exynos5250-dw-mshc";
>> +        reg = <0x12510000 0x1000>;
>> +        interrupts = <0 142 0>;
>> +        clocks = <&cmu CLK_SDMMC0>, <&cmu CLK_SCLK_MMC0>;
>> +        clock-names = "biu", "ciu";
>> +        fifo-depth = <0x80>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        status = "disabled";
>> +    };
>> +
>> +    mshc_1: mshc at 12520000 {
>> +        compatible = "samsung,exynos5250-dw-mshc";
>> +        reg = <0x12520000 0x1000>;
>> +        interrupts = <0 143 0>;
>> +        clocks = <&cmu CLK_SDMMC1>, <&cmu CLK_SCLK_MMC1>;
>> +        clock-names = "biu", "ciu";
>> +        fifo-depth = <0x80>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        status = "disabled";
>> +    };
>> +
>> +    amba {
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        compatible = "arm,amba-bus";
>> +        interrupt-parent = <&gic>;
>> +        ranges;
>> +
>> +        pdma0: pdma at 12680000 {
>> +            compatible = "arm,pl330", "arm,primecell";
>> +            reg = <0x12680000 0x1000>;
>> +            interrupts = <0 138 0>;
>> +            clocks = <&cmu CLK_PDMA0>;
>> +            clock-names = "apb_pclk";
>> +            #dma-cells = <1>;
>> +            #dma-channels = <8>;
>> +            #dma-requests = <32>;
>> +        };
>> +
>> +        pdma1: pdma at 12690000 {
>> +            compatible = "arm,pl330", "arm,primecell";
>> +            reg = <0x12690000 0x1000>;
>> +            interrupts = <0 139 0>;
>> +            clocks = <&cmu CLK_PDMA1>;
>> +            clock-names = "apb_pclk";
>> +            #dma-cells = <1>;
>> +            #dma-channels = <8>;
>> +            #dma-requests = <32>;
>> +        };
>> +    };
>> +
>> +    adc: adc at 126C0000 {
>> +        compatible = "samsung,exynos-adc-v3";
>> +        reg = <0x126C0000 0x100>, <0x10020718 0x4>;
>> +        interrupts = <0 137 0>;
>> +        clock-names = "adc", "sclk_tsadc";
>> +        clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
>> +        #io-channel-cells = <1>;
>> +        io-channel-ranges;
>> +        status = "disabled";
>> +    };
>> +
>> +    serial at 13800000 {
> 
> Please add label.

OK, I'll add lable as following:

	serial_0: serial at 13800000 {

> 
>> +        compatible = "samsung,exynos4210-uart";
>> +        reg = <0x13800000 0x100>;
>> +        interrupts = <0 109 0>;
>> +        clocks = <&cmu CLK_UART0>, <&cmu CLK_SCLK_UART0>;
>> +        clock-names = "uart", "clk_uart_baud0";
>> +        status = "disabled";
>> +    };
>> +
>> +    serial at 13810000 {

OK, I'll add lable as following:

	serial_1: serial at 13800000 {


Thanks for your review.

Best regards,
Chanwoo Choi
