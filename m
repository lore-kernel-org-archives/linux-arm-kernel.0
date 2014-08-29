From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Fri, 29 Aug 2014 11:21:20 +0530
Subject: [PATCH 12/14] arm64: dts: add Exynos7 based Espresso board dts
 file
In-Reply-To: <20140828040015.GC4972@localhost>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-4-git-send-email-ch.naveen@samsung.com>
 <20140828040015.GC4972@localhost>
Message-ID: <CAHfPSqBbaVJ07OpQY1GyPbUMJ8mR2eGPO0dZ0-6fwOVjre9A0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On 28 August 2014 09:30, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Wed, Aug 27, 2014 at 03:14:19PM +0530, Naveen Krishna Chatradhi wrote:
>> This patch adds initial dts file for the Espresso board
>> based on Exynos7 from Samsung.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/boot/dts/Makefile             |    1 +
>>  arch/arm64/boot/dts/exynos7-espresso.dts |   69 ++++++++++++++++++++++++++++++
>>  2 files changed, 70 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/exynos7-espresso.dts
>>
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index c52bdb0..d160de1 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -1,5 +1,6 @@
>>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>> +dtb-$(CONFIG_ARCH_EXYNOS7) += exynos7-espresso.dtb
>
> As mentioned on the dtsi patch, please create a subdirectory.

Sure, Will make it.
>
>>  targets += dtbs
>>  targets += $(dtb-y)
>> diff --git a/arch/arm64/boot/dts/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos7-espresso.dts
>> new file mode 100644
>> index 0000000..e35e83c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos7-espresso.dts
>> @@ -0,0 +1,69 @@
>> +/*
>> + * SAMSUNG Espresso board device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "exynos7.dtsi"
>> +
>> +/ {
>> +     model = "Samsung ESPRESSO board based on EXYNOS7";
>> +     compatible = "samsung,espresso", "samsung,exynos7";
>> +
>> +     chosen {
>> +             bootargs = "console=ttySAC2,115200n8 root=/dev/ram0 ramdisk=16384 initrd=0x42000000,16M init=/linuxrc";
>
> Having ramdisk bootargs like these in the upstream dts doesn't make much
> sense. Configure your bootloader to pass them in instead.

Right, We have tested with ramdisk. So, Left it that way.
Will remove this.

>
> You might want to specify the console through chosen instead, there's
> been recent support added for that.
>
>> +
>> +     memory at 40000000 {
>> +             device_type = "memory";
>> +             reg = <0x40000000 0xC0000000>;
>> +     };
>> +
>> +     mmc at 15740000 {
>> +             status = "okay";
>> +             num-slots = <1>;
>> +             broken-cd;
>> +             caps2-mmc-hs200-1_8v;
>> +             supports-highspeed;
>> +             non-removable;
>> +             card-detect-delay = <200>;
>> +             clock-frequency = <800000000>;
>> +             samsung,dw-mshc-ciu-div = <3>;
>> +             samsung,dw-mshc-sdr-timing = <0 4>;
>> +             samsung,dw-mshc-ddr-timing = <0 2>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_rdqs &sd0_bus1 &sd0_bus4 &sd0_bus8>;
>> +             bus-width = <8>;
>> +
>> +             slot at 0 {
>> +                     reg = <0>;
>> +                     bus-width = <8>;
>> +             };
>
> I thought the use of slot was deprecated. Why do you have it here?
>
> Also, as mentioned by others elsewhere, please use references instead
> of duplicating the structure here.

Sure, will rebase with the references.
>
>
> -Olof
Thanks for the review.


-- 
Thanks & Regards,
(: Nav :)
