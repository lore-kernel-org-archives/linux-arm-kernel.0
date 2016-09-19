From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Sep 2016 23:14:48 +0800
Subject: [PATCH v2 4/4] arm64: dts: add Pine64 support
In-Reply-To: <c7ad213f-e5d1-d5c5-a83c-af1c38d9c1d6@arm.com>
References: <20160909201029.24530-1-maxime.ripard@free-electrons.com>
 <20160909201029.24530-5-maxime.ripard@free-electrons.com>
 <CAGb2v65JZ7gnOZ_LkkvGv5-bqXeK1E1O3eno85zYBSndNpN=Qw@mail.gmail.com>
 <c7ad213f-e5d1-d5c5-a83c-af1c38d9c1d6@arm.com>
Message-ID: <CAGb2v64YNdikfPeOmjX3u9exenRAodWat6w6nzpKNZAE4CU-iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 6:11 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> On 10/09/16 03:33, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Sat, Sep 10, 2016 at 4:10 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>> From: Andre Przywara <andre.przywara@arm.com>
>>>
>>> The Pine64 is a cost-efficient development board based on the
>>> Allwinner A64 SoC.
>>> There are three models: the basic version with Fast Ethernet and
>>> 512 MB of DRAM (Pine64) and two Pine64+ versions, which both
>>> feature Gigabit Ethernet and additional connectors for touchscreens
>>> and a camera. Or as my son put it: "Those are smaller and these are
>>> missing." ;-)
>>> The two Pine64+ models just differ in the amount of DRAM
>>> (1GB vs. 2GB). Since U-Boot will figure out the right size for us and
>>> patches the DT accordingly we just need to provide one DT for the
>>> Pine64+.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> [Maxime: Removed the common DTSI and include directly the pine64 DTS]
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>  arch/arm64/boot/dts/Makefile                       |  1 +
>>>  arch/arm64/boot/dts/allwinner/Makefile             |  5 ++
>>>  .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  | 50 ++++++++++++++++
>>>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 70 ++++++++++++++++++++++
>>>  4 files changed, 126 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>>> index 6e199c903676..ddcbf5a2c17e 100644
>>> --- a/arch/arm64/boot/dts/Makefile
>>> +++ b/arch/arm64/boot/dts/Makefile
>>> @@ -1,4 +1,5 @@
>>>  dts-dirs += al
>>> +dts-dirs += allwinner
>>>  dts-dirs += altera
>>>  dts-dirs += amd
>>>  dts-dirs += amlogic
>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>>> new file mode 100644
>>> index 000000000000..1e29a5ae8282
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>> @@ -0,0 +1,5 @@
>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>>> +
>>> +always         := $(dtb-y)
>>> +subdir-y       := $(dts-dirs)
>>> +clean-files    := *.dtb
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
>>> new file mode 100644
>>> index 000000000000..790d14daaa6a
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
>>> @@ -0,0 +1,50 @@
>>> +/*
>>> + * Copyright (c) 2016 ARM Ltd.
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This library is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This library is distributed in the hope that it will be useful,
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
>>> +#include "sun50i-a64-pine64.dts"
>>> +
>>> +/ {
>>> +       model = "Pine64+";
>>> +       compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
>>> +
>>> +       /* TODO: Camera, Ethernet PHY, touchscreen, etc. */
>>> +};
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> new file mode 100644
>>> index 000000000000..da9bca51f5a9
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> @@ -0,0 +1,70 @@
>>> +/*
>>> + * Copyright (c) 2016 ARM Ltd.
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This library is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This library is distributed in the hope that it will be useful,
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
>>> +
>>> +#include "sun50i-a64.dtsi"
>>> +
>>> +/ {
>>> +       model = "Pine64";
>>> +       compatible = "pine64,pine64", "allwinner,sun50i-a64";
>>> +
>>> +       aliases {
>>> +               serial0 = &uart0;
>>> +       };
>>> +
>>> +       chosen {
>>> +               stdout-path = "serial0:115200n8";
>>> +       };
>>> +};
>>> +
>>> +&uart0 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&uart0_pins_a>;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&i2c1_pins>;
>>> +       status = "okay";
>>
>> Schematics say this is missing an external pull-up. Has anyone tried it?
>> Without a pull-up any access on the i2c bus should just block.
>
> I tried it a while ago (with an older kernel), though I had an external
> pull-up on the device side, I think. I can give it a try again with
> Maxime's branch once I find this I2C test device in one of my moving
> boxes ;-)
>
> Do other boards providing a Raspi-compatible header have an on-board
> pull-up here? So will (some) hardware extensions for the Raspi fail on
> the Pine64?

IIRC The Bananapi series have pull-ups on the default I2C pins.

>> Also this is on the RPi-2 compatible header. There's also an UART and SPI
>> that are standard for the RPi-2 header. We should consider enabling them
>> as well.
>
> Interesting topic ;-)
> As both interfaces can be configured for GPIO as well, I think Maxime
> voted to not declare them as special function in the upstream DT.
> UART0 is used for the console, so I guess some people may decide to use
> those UART2 header pins for GPIO. Similarly for SPI: if you don't need
> it, you get four (or five) additional GPIO.
>
> A kind of related issue arises for those BT/Wifi headers. 99.9% of the
> users will plug the Pine64 BT/WiFi module in there, at which point we
> could declare MMC1 as SDIO and UART1 as enabled to cover this.
> But then again nothing prevents people from building a custom module
> which uses those pins for something else. Port G at least does not
> multiplex any other IP to those pins - apart from GPIO, of course.
>
> So what is the exact policy here? In the end I think any pin (including
> UART0's PB8 and PB9) can be configured as GPIO, so do we make some
> assumptions about "sensible" or predominant usage?

My personal position is if the vendor explicitly labeled X pin as Y
peripheral, then we should enable it by default, since that is possibly
what many users would be expecting. We can list, but explicitly disable,
other peripherals that the vendor mentioned as optional or changeable.
Obviously most pins are changeable from the SoC PoV, so my focus here
is what the vendor intended.

Unfortunately I've not completely worked this out with Maxime yet,
and I am somewhat busy on other fronts lately. I'll be at ELCE this
year, so hopefully we'll get this sorted out soon.

> Does "# echo $DEVICE > /sys/devices/platform/$DEVICE/driver/unbind" work
> to get those pins free later in case one wants to configure them as
> GPIOs? In this case we may consider being more generous in declaring
> common use cases in the upstream DT for the sake of the majority of users.

I believe it does, but I've never actually tried it.

Regards
ChenYu
