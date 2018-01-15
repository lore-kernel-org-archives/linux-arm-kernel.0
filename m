From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Jan 2018 12:09:53 -0600
Subject: [PATCH] arm64: dts: rockchip: add roc-rk3328-cc board
In-Reply-To: <10243464.nJpoDBzbVB@phil>
References: <20180106094538.15568-1-djw@t-chip.com.cn>
 <20180111203033.mnap7tijbfsvr5pa@rob-hp-laptop>
 <10243464.nJpoDBzbVB@phil>
Message-ID: <CAL_JsqKSvyi0HRFkwYfr2HS_xBuQfTYphUYP7ass1nQn3EKLgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 2:33 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Rob,
>
> Am Donnerstag, 11. Januar 2018, 14:30:33 CET schrieb Rob Herring:
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
>> > new file mode 100644
>> > index 0000000..2134baf
>> > --- /dev/null
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
>> > @@ -0,0 +1,313 @@
>> > +/*
>> > + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
>> > + *
>> > + * This file is dual-licensed: you can use it either under the terms
>> > + * of the GPL or the X11 license, at your option. Note that this dual
>> > + * licensing only applies to this file, and not this project as a
>> > + * whole.
>> > + *
>> > + *  a) This library is free software; you can redistribute it and/or
>> > + *     modify it under the terms of the GNU General Public License as
>> > + *     published by the Free Software Foundation; either version 2 of the
>> > + *     License, or (at your option) any later version.
>> > + *
>> > + *     This library is distributed in the hope that it will be useful,
>> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + *     GNU General Public License for more details.
>> > + *
>> > + * Or, alternatively,
>> > + *
>> > + *  b) Permission is hereby granted, free of charge, to any person
>> > + *     obtaining a copy of this software and associated documentation
>> > + *     files (the "Software"), to deal in the Software without
>> > + *     restriction, including without limitation the rights to use,
>> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> > + *     sell copies of the Software, and to permit persons to whom the
>> > + *     Software is furnished to do so, subject to the following
>> > + *     conditions:
>> > + *
>> > + *     The above copyright notice and this permission notice shall be
>> > + *     included in all copies or substantial portions of the Software.
>> > + *
>> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> > + *     OTHER DEALINGS IN THE SOFTWARE.
>> > + */
>>
>> Use SPDX license tag.
>
> It looks like Thomas' SPDX documentation patches are not yet merged
> and there were smaller protests about SPDX information only being
> available on some external website, so just for my understanding, SPDX
> is the agreed standard now, right?

His series adds the license text for all the tags which Russell said
addressed his concerns.

I think it is not yet merged mainly because Thomas has been busy with
Spectre and Meltdown.

> And judging by the SPDX conversion for Rockchip dts I have in my inbox
> the correct tags should probably be
>         // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> due to the
> "All devicetrees claim to be either GPL or X11 while the actual license
> text is MIT. Therefore we use MIT for the SPDX tag as X11 is clearly
> wrong."

Right.


>> > +&i2c1 {
>> > +   status = "okay";
>> > +
>> > +   rk805: rk805 at 18 {
>>
>> pmic at 18
>>
>> > +           compatible = "rockchip,rk805";
>> > +           reg = <0x18>;
>> > +           interrupt-parent = <&gpio1>;
>> > +           interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
>> > +           #clock-cells = <1>;
>> > +           clock-output-names = "xin32k", "rk805-clkout2";
>> > +           gpio-controller;
>> > +           #gpio-cells = <2>;
>> > +           pinctrl-names = "default";
>> > +           pinctrl-0 = <&pmic_int_l>;
>> > +           rockchip,system-power-controller;
>> > +           wakeup-source;
>> > +
>> > +           vcc1-supply = <&vcc_sys>;
>> > +           vcc2-supply = <&vcc_sys>;
>> > +           vcc3-supply = <&vcc_sys>;
>> > +           vcc4-supply = <&vcc_sys>;
>> > +           vcc5-supply = <&vcc_io>;
>> > +           vcc6-supply = <&vcc_io>;
>> > +
>> > +           regulators {
>> > +                   vdd_logic: DCDC_REG1 {
>>
>> Don't use '_' in node names.
>
> The driver binds against the node names including the underscores.
> (with regulator-compatible being deprecated)

Okay. You've probably told me that before (and will again next time I forget).

Rob
