From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 14:45:52 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: dts: sun7i: Add dts file for
 Wits Pro A20 DKT
In-Reply-To: <CAGb2v65TEogqYFAfen1VnOaiepvez5t8Oh+Q=OYsRS_aZUMO3A@mail.gmail.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-6-git-send-email-hdegoede@redhat.com>
 <20150731102028.GE2564@lukather>
 <CAGb2v65TEogqYFAfen1VnOaiepvez5t8Oh+Q=OYsRS_aZUMO3A@mail.gmail.com>
Message-ID: <55BB6E00.9090202@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31-07-15 12:25, Chen-Yu Tsai wrote:
> On Fri, Jul 31, 2015 at 6:20 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Fri, Jul 31, 2015 at 10:59:54AM +0200, Hans de Goede wrote:
>>> From: Jelle de Jong <jelledejong@powercraft.nl>
>>>
>>> The Wits Pro A20 DKT is an A20 Development KiT with 1G RAM, 4G NAND,
>>> sdio wifi, 1Gbit ethernet, 1024x768 lcd screen with ft5x_ts touchscreen
>>> and a ton of IO connectors.
>>>
>>> Note there seem to be multiple sdcard slots on the board (4 in total), but
>>> other then mmc0 none of these are hooked up by default, there is a ton of
>>> dip-switches which likely allow hooking some of these up, but the
>>> documentation of the board only describes the use of a fraction of them,
>>> so for now we only support mmc0.
>>>
>>> Signed-off-by: Jelle de Jong <jelledejong@powercraft.nl>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Also see: http://www.merrii.com/en/pla_d.asp?id=163
>>> ---
>>>   arch/arm/boot/dts/Makefile                       |   3 +-
>>>   arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 209 +++++++++++++++++++++++
>>>   2 files changed, 211 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index f830e1f..151a413 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -595,7 +595,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>>        sun7i-a20-orangepi-mini.dtb \
>>>        sun7i-a20-pcduino3.dtb \
>>>        sun7i-a20-pcduino3-nano.dtb \
>>> -     sun7i-a20-wexler-tab7200.dtb
>>> +     sun7i-a20-wexler-tab7200.dtb \
>>> +        sun7i-a20-wits-pro-a20-dkt.dtb
>>
>> The indentation is off.
>>
>>>   dtb-$(CONFIG_MACH_SUN8I) += \
>>>        sun8i-a23-evb.dtb \
>>>        sun8i-a23-ippo-q8h-v5.dtb \
>>> diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
>>> new file mode 100644
>>> index 0000000..db4d32c
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
>>> @@ -0,0 +1,209 @@
>>> +/*
>>> + * Copyright 2015 Jelle de Jong <jelledejong@powercraft.nl>
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This file is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This file is distributed in the hope that it will be useful,
>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *     GNU General Public License for more details.
>>> + *
>>> + * Or, alternatively,
>>> + *
>>> + *  b) Permission is hereby granted, free of charge, to any person
>>> + *     obtaining a copy of this software and associated documentation
>>> + *     files (the "Software"), to deal in the Software without
>>> + *     restriction, including without limitation the rights to use,
>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>> + *     sell copies of the Software, and to permit persons to whom the
>>> + *     Software is furnished to do so, subject to the following
>>> + *     conditions:
>>> + *
>>> + *     The above copyright notice and this permission notice shall be
>>> + *     included in all copies or substantial portions of the Software.
>>> + *
>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "sun7i-a20.dtsi"
>>> +#include "sunxi-common-regulators.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +/ {
>>> +     model = "Wits Pro A20 DKT";
>>> +     compatible = "wits,pro-a20-dkt", "allwinner,sun7i-a20";
>>> +
>>> +     aliases {
>>> +             serial0 = &uart0;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>> +
>>> +     reg_vmmc3: vmmc3 {
>>> +             compatible = "regulator-fixed";
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&vmmc3_pin_ap6xxx_wl_regon>;
>>> +             regulator-name = "vmmc3";
>>> +             regulator-min-microvolt = <3300000>;
>>> +             regulator-max-microvolt = <3300000>;
>>> +             enable-active-high;
>>> +             gpio = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
>>> +     };
>>
>> It's not really vmmc. The reg_on stuff is actually more of a reset
>> line: when tied to VCC, the WLAN part of the chip and its regulators
>> are enabled, while when it's tied to ground, the WLAN is in reset, and
>> the internal regulators disabled.
>>
>> So it can be seen as either an active-low reset line, or an
>> active-high regulator for the WiFi part, but VMMC is the power line of
>> the MMC bus itself, which usually is provided by a regulator through
>> the pin 22 of the AP6210, usually tied directly to the 3.3V line.
>>
>> So you actually have two regulators here: one for vmmc (reg_3v3), and
>> one for reg_on which is the one that you just defined.
>>
>> Note that it's a bit of a pain for now to support such cases, as
>> there's nothing to tie something from the DT to an SDIO device. I
>> don't have a better solution than marking it always-on at the moment,
>> with a big FIXME comment on top... :/
>
> One could use the mmc-pwr-seq stuff. I don't know if it has been
> extended for multiple GPIOs, not that you would need it in this use
> case.

Yes the mmc-pwr-seq stuff seems to be the right thing to use for this,
I'll try to get that to work and post a new version of this patch.

Regards,

Hans
