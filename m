From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Thu, 11 Sep 2014 14:12:34 +0530
Subject: [PATCH v2 5/7] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <02f801cfcbde$24a40160$6dec0420$@kernel.org>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
 <1409672143-8574-6-git-send-email-ch.naveen@samsung.com>
 <02f801cfcbde$24a40160$6dec0420$@kernel.org>
Message-ID: <CAHfPSqAJF4PNr8BAzY=pFNTKjivrkWUz2Ceg8a0z0w1ad-O14w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 September 2014 08:58,  <kgene@kernel.org> wrote:
> Naveen Krishna Chatradhi wrote:
>>
>> Add initial device tree nodes for EXYNOS7 SoC and board dts file
>> to support Espresso board based on Exynos7 SoC.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/boot/dts/Makefile                    |    1 +
>>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   31 +++++
>>  arch/arm64/boot/dts/exynos/exynos7.dtsi         |  168 +++++++++++++++++++++++
>>  3 files changed, 200 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi
>
> [...]
>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>> new file mode 100644
>> index 0000000..e593af55
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>> @@ -0,0 +1,168 @@
>> +/*
>> + * SAMSUNG EXYNOS7 SoC device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <dt-bindings/clock/exynos7-clk.h>
>> +
>> +/ {
>> +     compatible = "samsung,exynos7";
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <2>;
>
> +       #address-cells = <1>; ?
>
> Hmm...I can't see any 64-bit address here.

All the SoC peripherals have been put into the soc node and ranges
property in that node is used to convert 64-bit to 32-bit addresses.
But since this is a 64-bit SoC, we use #address-cells as 2.

>
>> +     #size-cells = <2>;
>> +
>
> [...]
>
>> +
>> +     soc: soc {
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges = <0 0 0 0x18000000>;
>> +
>> +             chipid at 10000000 {
>> +                     compatible = "samsung,exynos4210-chipid";
>> +                     reg = <0x10000000 0x100>;
>> +             };
>
> Maybe this is not required? There is no check chipid in arm/arm64.

This is only describing the hardware and it does not depend on linux
using this information. And support for chip id can be used later for
64-bit Exynos platforms as well.

>
> [...]
>
>> +             timer {
>> +                     compatible = "arm,armv8-timer";
>> +                     interrupts = <1 13 0xff01>,
>> +                                  <1 14 0xff01>,
>> +                                  <1 11 0xff01>,
>> +                                  <1 10 0xff01>;
>
> clock-frequency ?

That is programmed by the bootloader / firmware.

>
> [...]
>
> - Kukjin
>

Thanks,
-- 
Shine bright,
(: Nav :)
