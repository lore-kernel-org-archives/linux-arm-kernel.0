From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 24 Jul 2015 07:57:15 +0200
Subject: [PATCH v2] ARM: dts: rockchip: Add veyron-speedy board
In-Reply-To: <2973046.XRmeZKJr7n@diego>
References: <1437670249-9510-1-git-send-email-romain.perier@gmail.com>
 <2973046.XRmeZKJr7n@diego>
Message-ID: <CABgxDoJpeNBS4xeu0xJgBE5RyJQaU8qO99n7+Js=eKODDLA37A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

yep, sorry.

In fact I rebased my work on 4.2-rc3... (I usually use linux-next for
my work... not this time...). Next time ask for a v3 ;)
Thanks,
Romain

2015-07-23 22:21 GMT+02:00 Heiko St?bner <heiko@sntech.de>:
> Hi Romain,
>
> I've applied the patch to my dts branch for 4.3 after fixing some smallish
> issues:
>
>
> Am Donnerstag, 23. Juli 2015, 18:50:49 schrieb Romain Perier:
>> Which is formally known as The Asus C201 chromebook
>
>                                                 ^ typo the with small "t"
>
>>
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>>  - Remove dvs-gpio (not used in mainline yet)
>>  - Remove edp subnode in pinctrl (not used in mainline yet)
>>  - Reordering disable-wp correctly
>>
>>  Documentation/devicetree/bindings/arm/rockchip.txt |  10 +-
>>  arch/arm/boot/dts/Makefile                         |   3 +-
>>  arch/arm/boot/dts/rk3288-veyron-speedy.dts         | 155
>> +++++++++++++++++++++ 3 files changed, 166 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/rk3288-veyron-speedy.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
>> b/Documentation/devicetree/bindings/arm/rockchip.txt index
>> 6de18bd2..da02022 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
>> @@ -37,4 +37,12 @@ Rockchip platforms device tree bindings
>>  - Google Pinky (dev-board):
>>      Required root node properties:
>>        - compatible = "google,veyron-pinky-rev2", "google,veyron-pinky",
>> -                  "google,veyron", "rockchip,rk3288";
>> \ No newline at end of file
>> +                  "google,veyron", "rockchip,rk3288";
>> +
>> +- Google Speedy (Asus C201 Chromebook):
>> +    Required root node properties:
>> +      - compatible = "google,veyron-speedy-rev9",
>> "google,veyron-speedy-rev8", +                     "google,veyron-speedy-rev7",
>> "google,veyron-speedy-rev6",
>> +                  "google,veyron-speedy-rev5", "google,veyron-speedy-rev4",
>> +                  "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
>> +                  "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 4993b3b..bf5225a 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -490,7 +490,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>>       rk3288-firefly-beta.dtb \
>>       rk3288-firefly.dtb \
>>       rk3288-veyron-jerry.dtb \
>> -     rk3288-veyron-pinky.dtb
>> +     rk3288-veyron-pinky.dtb \
>> +     rk3288-veyron-speedy.dtb
>>  dtb-$(CONFIG_ARCH_S3C24XX) += \
>>       s3c2416-smdk2416.dtb
>>  dtb-$(CONFIG_ARCH_S3C64XX) += \
>
> both the board description as well as the Makefile did not apply cleanly, as
> you seem to have based it on some unknown branch.
> Please try to base patches on either linux-next or my version specific topic
> branch - v4.3-armsoc/dts in this case.
>
>
>> diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
>> b/arch/arm/boot/dts/rk3288-veyron-speedy.dts new file mode 100644
>> index 0000000..fdb2a73
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Google Veyron Speedy Rev 1+ board device tree source
>> + *
>> + * Copyright 2015 Google, Inc
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
>> + *  Or, alternatively,
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
>> +#include "rk3288-veyron-chromebook.dtsi"
>> +#include "cros-ec-sbs.dtsi"
>> +
>> +/ {
>> +     model = "Google Speedy";
>> +     compatible = "google,veyron-speedy-rev9", "google,veyron-speedy-rev8",
>> +                  "google,veyron-speedy-rev7", "google,veyron-speedy-rev6",
>> +                  "google,veyron-speedy-rev5", "google,veyron-speedy-rev4",
>> +                  "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
>> +                  "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
>> +
>> +     panel_regulator: panel-regulator {
>> +             compatible = "regulator-fixed";
>> +             enable-active-high;
>> +             gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&lcd_enable_h>;
>> +             regulator-name = "panel_regulator";
>> +             vin-supply = <&vcc33_sys>;
>> +     };
>> +
>> +     vcc18_lcd: vcc18-lcd {
>> +             compatible = "regulator-fixed";
>> +             enable-active-high;
>> +             gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&avdd_1v8_disp_en>;
>> +             regulator-name = "vcc18_lcd";
>> +             regulator-always-on;
>> +             regulator-boot-on;
>> +             vin-supply = <&vcc18_wl>;
>> +     };
>> +
>> +     backlight_regulator: backlight-regulator {
>> +             compatible = "regulator-fixed";
>> +             enable-active-high;
>> +             gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&bl_pwr_en>;
>> +             regulator-name = "backlight_regulator";
>> +             vin-supply = <&vcc33_sys>;
>> +             startup-delay-us = <15000>;
>> +     };
>> +};
>> +
>> +&rk808 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
>
> removed the dvs_1 and dvs_2 pinctrl accesses here.
>
> The pin definitions below are staying, but I'd like to completely keep from
> using the pins until the support lands. The binding change seems to have made
> it today, but I'd like to wait until the regulator change also gets accepted
> too.
>
>
> Heiko
