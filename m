From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 17 Aug 2017 17:08:19 +0800
Subject: [linux-sunxi] Re: [PATCH] ARM: sun8i: a83t: Add device tree for
 Sinovoip Bananapi BPI-M3
In-Reply-To: <0dbfd9d8f83ac53c1538e86c4e02883e@aosc.io>
References: <20170817034048.11601-1-wens@csie.org>
 <0dbfd9d8f83ac53c1538e86c4e02883e@aosc.io>
Message-ID: <CAGb2v64WqSR+xp2Qrrx5hWhHCi9yZwoOackzRXx1VRah=8O4-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 1:11 PM,  <icenowy@aosc.io> wrote:
> ? 2017-08-17 11:40?Chen-Yu Tsai ???
>>
>> The BPI-M3 is an Allwinner A83T based SBC in the Bananapi/Bpi family.
>> It is roughly the same form factor as the BPI-M1+, with roughly the
>> same peripherals and connectors:
>>
>>   - 2GB LPDDR3 DRAM
>>   - 8GB eMMC
>>   - Micro-SD card slot
>>   - HDMI output
>>   - Headset (stereo + mic) jack
>>   - Onboard mic
>>   - Gigabit Ethernet with RTL8211E transceiver
>>   - Ampak AP6212 WiFi + BT
>>   - USB OTG connector
>>   - USB-to-SATA bridge connected through a USB 2.0 hub
>>   - Consumer IR receiver
>>   - MIPI DSI LCD panel connector
>>   - Camera interface (parallel and MIPI CSI) connector
>>   - 3 LEDs (Red, Green, Blue), of which 2 are controllable (GB)
>>   - Raspberry Pi 2 compatible GPIO header
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> Note that the file name follows the convention of most of the other
>> bananapi boards, that is the vendor "sinovoip" is not included in
>> the name. This deviates from what is already in U-boot.
>>
>> This applies on top of my A83t USB patches.
>>
>> ---
>>  arch/arm/boot/dts/Makefile                   |   1 +
>>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 148
>> +++++++++++++++++++++++++++
>>  2 files changed, 149 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index e0d77ab79f5f..791fecc0774a 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -903,6 +903,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>         sun8i-a33-q8-tablet.dtb \
>>         sun8i-a33-sinlinx-sina33.dtb \
>>         sun8i-a83t-allwinner-h8homlet-v2.dtb \
>> +       sun8i-a83t-bananapi-m3.dtb \
>>         sun8i-a83t-cubietruck-plus.dtb \
>>         sun8i-h2-plus-orangepi-zero.dtb \
>>         sun8i-h3-bananapi-m2-plus.dtb \
>> diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> new file mode 100644
>> index 000000000000..2bafd7e99ef7
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> @@ -0,0 +1,148 @@
>> +/*
>> + * Copyright 2017 Chen-Yu Tsai
>> + *
>> + * Chen-Yu Tsai <wens@csie.org>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +#include "sun8i-a83t.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +       model = "Banana Pi BPI-M3";
>> +       compatible = "sinovoip,bpi-m3", "allwinner,sun8i-a83t";
>
>
> Should we continue to use sinovoip,bpi-mx-xxx or use bananapi,mx-xxx
> instead?

The vendor listed for "bananapi" is "BIPAI KEJI LIMITED", which you and
I know is probably the Chinese pronunciation of "BPi Technologies".
However I can't seem to find any trademark registrations.

The dispute around the Banana Pi brand was confusing. I'd hate to see
it again. I'll make some inquiries about this first.

ChenYu
