From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 14 Aug 2013 16:34:33 +0530
Subject: [PATCH] ARM: DRA7: dts: Add the dts files for dra7 SoC and
 dra7-evm board
In-Reply-To: <18ceeaca6539d2c2ef88bf5a560a77f3@www.loen.fr>
References: <1376475929-26050-1-git-send-email-rnayak@ti.com>
 <18ceeaca6539d2c2ef88bf5a560a77f3@www.loen.fr>
Message-ID: <520B6441.6030200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 August 2013 04:04 PM, Marc Zyngier wrote:
> On 2013-08-14 11:25, Rajendra Nayak wrote:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> Add minimal device tree source needed for DRA7 based SoCs.
>> Also add a board dts file for the dra7-evm (based on dra752)
>> which contains 1.5G of memory with 1G interleaved and 512MB
>> non-interleaved. Also added in the board file are pin configuration
>> details for i2c, mcspi and uart devices on board.
>>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> ---
>> Benoit, I am reposting the dts files for dra so you can pick it up
>> for 3.12.
>> Rest of the core support is already pulled in by Tony.
> 
> [...]
> 
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> new file mode 100644
>> index 0000000..ad18fb2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -0,0 +1,574 @@
>> +/*
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + * Based on "omap4.dtsi"
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/pinctrl/dra.h>
>> +
>> +#include "skeleton.dtsi"
>> +
>> +/ {
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>> +
>> +    compatible = "ti,dra7xx";
>> +    interrupt-parent = <&gic>;
>> +
>> +    aliases {
>> +        serial0 = &uart1;
>> +        serial1 = &uart2;
>> +        serial2 = &uart3;
>> +        serial3 = &uart4;
>> +        serial4 = &uart5;
>> +        serial5 = &uart6;
>> +    };
>> +
>> +    cpus {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        cpu at 0 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a15";
>> +            reg = <0>;
>> +        };
>> +        cpu at 1 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a15";
>> +            reg = <1>;
>> +        };
>> +    };
>> +
>> +    timer {
>> +        compatible = "arm,armv7-timer";
>> +        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
>> +    };
>> +
>> +    gic: interrupt-controller at 48211000 {
>> +        compatible = "arm,cortex-a15-gic";
>> +        interrupt-controller;
>> +        #interrupt-cells = <3>;
>> +        reg = <0x48211000 0x1000>,
>> +              <0x48212000 0x1000>,
>> +              <0x48214000 0x2000>,
>> +              <0x48216000 0x2000>;
> 
> If you have the virtualization extensions, where is the maintenance interrupt?

missing indeed, will add. thanks.

> 
>         M.
