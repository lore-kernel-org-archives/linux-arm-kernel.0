From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Dec 2015 22:37:11 +0800
Subject: [linux-sunxi][PATCH v2 1/5] ARM: dts: sunxi: Add
 sunxi-itead-core-common.dtsi
In-Reply-To: <CAGb2v64f0wGdg4fZoQhZaVgBERi63e51U_sJBzxxbgPkY85pHw@mail.gmail.com>
References: <1450537521-6476-1-git-send-email-codekipper@gmail.com>
 <1450537521-6476-2-git-send-email-codekipper@gmail.com>
 <CAGb2v64f0wGdg4fZoQhZaVgBERi63e51U_sJBzxxbgPkY85pHw@mail.gmail.com>
Message-ID: <CAGb2v650ApW=h_ZPz-=xYrfAmo4+bvgZGqjf_OC1YB7MaVv5HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 2:18 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi,
>
> On Sat, Dec 19, 2015 at 11:05 PM,  <codekipper@gmail.com> wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Itead have a core module board that can be populated with either
>> an Allwinner A10 or A20 SoC. This patch creates a common dtsi
>> which these boards can use.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  arch/arm/boot/dts/sunxi-itead-core-common.dtsi | 114 +++++++++++++++++++++++++
>>  1 file changed, 114 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>>
>> diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>> new file mode 100644
>> index 0000000..41449fa
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>> @@ -0,0 +1,114 @@
>> +/*
>> + * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>
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
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>> +
>> +/ {
>> +       aliases {
>> +               serial0 = &uart0;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +};
>> +
>> +&ahci {
>> +       target-supply = <&reg_ahci_5v>;
>> +       status = "okay";
>> +};
>> +
>> +&codec {
>> +       status = "okay";
>> +};
>> +
>> +&ehci0 {
>> +       status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&i2c1_pins_a>;
>> +       status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +       status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +       status = "okay";
>> +};
>> +
>> +&reg_ahci_5v {
>> +       pinctrl-0 = <&ahci_pwr_pin_a>;
>> +       gpio = <&pio 1 8 GPIO_ACTIVE_HIGH>;
>
> These 2 lines are in sunxi-common-regulators.dtsi. No need to repeat them here.
>
> Otherwise,
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

On second thought: What happens when you have a base board that doesn't support
all the peripherals you enabled here? Like a small baseboard without SATA?

Thanks
ChenYu

>> +       status = "okay";
>> +};
>> +
>> +&reg_usb1_vbus {
>> +       status = "okay";
>> +};
>> +
>> +&reg_usb2_vbus {
>> +       status = "okay";
>> +};
>> +
>> +&uart0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&uart0_pins_a>;
>> +       status = "okay";
>> +};
>> +
>> +&usbphy {
>> +       usb1_vbus-supply = <&reg_usb1_vbus>;
>> +       usb2_vbus-supply = <&reg_usb2_vbus>;
>> +       status = "okay";
>> +};
>> --
>> 1.9.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
