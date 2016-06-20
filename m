From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 20 Jun 2016 18:55:44 +0200
Subject: [PATCH] ARM: sun8i: Add Parrot Board DTS
In-Reply-To: <CAGb2v66_iUMd5V=9Np4Kqqv+yqq2HbjoPhC3Z6cpHFrMzkddvw@mail.gmail.com>
References: <1465812931-22824-1-git-send-email-quentin.schulz@free-electrons.com>
 <1465812931-22824-2-git-send-email-quentin.schulz@free-electrons.com>
 <CAGb2v64jduBijEXzsKbOpSvLd9YHwO=qpSyPSDuYtMPg8wfKzA@mail.gmail.com>
 <575FFFBE.5090107@free-electrons.com>
 <CAGb2v67JGG35odB7kEAoF0kGes=KRGoREOSTc_GM0B4A+8cKWg@mail.gmail.com>
 <20160620154452.GL26668@lukather>
 <CAGb2v66_iUMd5V=9Np4Kqqv+yqq2HbjoPhC3Z6cpHFrMzkddvw@mail.gmail.com>
Message-ID: <ab8df5d6-bca2-a3f6-1734-acd5387c0ece@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-06-16 18:30, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Jun 20, 2016 at 11:44 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi,
>>
>> On Tue, Jun 14, 2016 at 09:19:58PM +0800, Chen-Yu Tsai wrote:
>>> On Tue, Jun 14, 2016 at 8:59 PM, Quentin Schulz
>>> <quentin.schulz@free-electrons.com> wrote:
>>>> Hi,
>>>>
>>>> On 13/06/2016 15:04, Chen-Yu Tsai wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Jun 13, 2016 at 6:15 PM, Quentin Schulz
>>>>> <quentin.schulz@free-electrons.com> wrote:
>>>>>> The Parrot Board is an evaluation board with an Allwinner R16 (assumed
>>>>>> to be close to an Allwinner A33), 4GB of NAND, 512MB of RAM, USB host
>>>>>
>>>>> You say NAND here, but you enable mmc2 for eMMC below. Please correct it.
>>>>>
>>>>
>>>> ACK.
>>>>
>>>>>> and OTG, a WiFi/Bluetooth combo chip, a micro SD Card reader, 2
>>>>>> controllable buttons, an LVDS port with separated backlight and
>>>>>> capacitive touch panel ports, an audio/microphone jack, a camera CSI
>>>>>> port, 2 sets of 22 GPIOs and an accelerometer.
>>>>>
>>>>> I assume the board is this one:
>>>>>
>>>>> https://world.taobao.com/item/530374411673.htm
>>>>>
>>>>
>>>> Definitely looks like it.
>>>>
>>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/Makefile             |   1 +
>>>>>>  arch/arm/boot/dts/sun8i-r16-parrot.dts | 333 +++++++++++++++++++++++++++++++++
>>>>>>  2 files changed, 334 insertions(+)
>>>>>>  create mode 100644 arch/arm/boot/dts/sun8i-r16-parrot.dts
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>>>> index 06b6c2d..1149512 100644
>>>>>> --- a/arch/arm/boot/dts/Makefile
>>>>>> +++ b/arch/arm/boot/dts/Makefile
>>>>>> @@ -760,6 +760,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>>>>>         sun8i-a33-ippo-q8h-v1.2.dtb \
>>>>>>         sun8i-a33-q8-tablet.dtb \
>>>>>>         sun8i-a33-sinlinx-sina33.dtb \
>>>>>> +       sun8i-r16-parrot.dtb \
>>>>>>         sun8i-a83t-allwinner-h8homlet-v2.dtb \
>>>>>>         sun8i-a83t-cubietruck-plus.dtb \
>>>>>>         sun8i-h3-orangepi-2.dtb \
>>>>>> diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
>>>>>> new file mode 100644
>>>>>> index 0000000..75e2420
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
>>>>>> @@ -0,0 +1,333 @@
>>>>>> +/*
>>>>>> + * Copyright 2015 Quentin Schulz
>>>>>> + *
>>>>>> + * Quentin Schulz <quentin.schulz@free-electrons.com>
>>>>>> + *
>>>>>> + * This file is dual-licensed: you can use it either under the terms
>>>>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>>>>> + * licensing only applies to this file, and not this project as a
>>>>>> + * whole.
>>>>>> + *
>>>>>> + *  a) This file is free software; you can redistribute it and/or
>>>>>> + *     modify it under the terms of the GNU General Public License as
>>>>>> + *     published by the Free Software Foundation; either version 2 of the
>>>>>> + *     License, or (at your option) any later version.
>>>>>> + *
>>>>>> + *     This file is distributed in the hope that it will be useful,
>>>>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>> + *     GNU General Public License for more details.
>>>>>> + *
>>>>>> + * Or, alternatively,
>>>>>> + *
>>>>>> + *  b) Permission is hereby granted, free of charge, to any person
>>>>>> + *     obtaining a copy of this software and associated documentation
>>>>>> + *     files (the "Software"), to deal in the Software without
>>>>>> + *     restriction, including without limitation the rights to use,
>>>>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>>>>> + *     sell copies of the Software, and to permit persons to whom the
>>>>>> + *     Software is furnished to do so, subject to the following
>>>>>> + *     conditions:
>>>>>> + *
>>>>>> + *     The above copyright notice and this permission notice shall be
>>>>>> + *     included in all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>>>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>>>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>>>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>>>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>>>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + */
>>>>>> +
>>>>>> +/dts-v1/;
>>>>>> +#include "sun8i-a33.dtsi"
>>>>>> +#include "sunxi-common-regulators.dtsi"
>>>>>> +
>>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>>> +#include <dt-bindings/input/input.h>
>>>>>> +
>>>>>> +/ {
>>>>>> +       model = "Allwinner Parrot EVB R16";
>>>>>> +       compatible = "allwinner,parrot-evb-r16", "allwinner,sun8i-a33";
>>>>>> +
>>>>>> +       aliases {
>>>>>> +               serial0 = &uart0;
>>>>>> +       };
>>>>>> +
>>>>>> +       chosen {
>>>>>> +               stdout-path = "serial0:115200n8";
>>>>>> +       };
>>>>>> +
>>>>>> +       leds {
>>>>>> +               compatible = "gpio-leds";
>>>>>> +               pinctrl-names = "default";
>>>>>> +               pinctrl-0 = <&led_pins_r16>;
>>>>>
>>>>> IMO r16 is too generic. You may want to add parrot_ or parrot_evb_ to it.
>>>>> Same goes for all the other r16 identifier names.
>>>>>
>>>>
>>>> ACK.
>>>>
>>>>>> +
>>>>>> +               led1 {
>>>>>> +                       label = "r16:led1:usr";
>>>>>> +                       gpio = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
>>>>>> +               };
>>>>>> +
>>>>>> +               led2 {
>>>>>> +                       label = "r16:led2:usr";
>>>>>> +                       gpio = <&pio 4 16 GPIO_ACTIVE_HIGH>; /* PE16 */
>>>>>> +               };
>>>>>> +       };
>>>>>> +
>>>>>> +       wifi_pwrseq: wifi_pwrseq {
>>>>>> +               compatible = "mmc-pwrseq-simple";
>>>>>> +               reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
>>>>>> +       };
>>>>>> +
>>>>>> +};
>>>>>> +
>>>>>> +&ehci0 {
>>>>>> +       status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&i2c1 {
>>>>>> +       pinctrl-names = "default";
>>>>>> +       pinctrl-0 = <&i2c1_pins_a>;
>>>>>> +       status = "okay";
>>>>>
>>>>> Nothing connected? A comment mentioning which connector this is on
>>>>> if it's not directly connecting something on the board would be nice.
>>>>>
>>>>
>>>> An accelerometer is connected to this i2c, but:
>>>> 1) The given address of the i2c device given by i2cdetect is not the
>>>> same as specified in both fex and schematics.
>>>> 2) The accelerometer has a "product reference" on the schematics for a
>>>> Broadcom BMA250 but the associated driver does not work with it.
>>>>
>>>> So there is an accelerometer connected to this i2c but I've not found
>>>> yet what can drive it. I could add a comment specifying the
>>>> accelerometer is attached to this i2c or remove the node?
>>>
>>> A comment will suffice, until you figure out what exactly is on there.
>>>
>>>>
>>>>>> +};
>>>>>> +
>>>>>> +&lradc {
>>>>>> +       vref-supply = <&reg_aldo3>;
>>>>>> +       status = "okay";
>>>>>> +
>>>>>> +       button at 0 {
>>>>>> +               label = "V+";
>>>>>> +               linux,code = <KEY_VOLUMEUP>;
>>>>>> +               channel = <0>;
>>>>>> +               voltage = <190000>;
>>>>>> +       };
>>>>>> +
>>>>>> +       button at 1 {
>>>>>> +               label = "V-";
>>>>>> +               linux,code = <KEY_VOLUMEDOWN>;
>>>>>> +               channel = <0>;
>>>>>> +               voltage = <390000>;
>>>>>> +       };
>>>>>> +
>>>>>> +};
>>>>>> +
>>>>>> +&mmc0 {
>>>>>> +       pinctrl-names = "default";
>>>>>> +       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_parrot>;
>>>>>> +       vmmc-supply = <&reg_dcdc1>;
>>>>>> +       cd-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
>>>>>> +       bus-width = <4>;
>>>>>> +       status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&mmc1 {
>>>>>> +       pinctrl-names = "default";
>>>>>> +       pinctrl-0 = <&mmc1_pins_a>, <&wifi_reset_pin_r16>;
>>>>>> +       vmmc-supply = <&reg_aldo1>;
>>>>>
>>>>> This looks fishy. See below.
>>>>>
>>>>>> +       mmc-pwrseq = <&wifi_pwrseq>;
>>>>>> +       bus-width = <4>;
>>>>>> +       non-removable;
>>>>>> +       status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&mmc2 {
>>>>>> +       pinctrl-names = "default";
>>>>>> +       pinctrl-0 = <&mmc2_8bit_pins>;
>>>>>> +       vmmc-supply = <&reg_dcdc1>;
>>>>>> +       bus-width = <8>;
>>>>>> +       non-removable;
>>>>>> +       cap-mmc-hw-reset;
>>>>>> +       status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&mmc2_8bit_pins {
>>>>>> +       allwinner,drive = <SUN4I_PINCTRL_40_MA>;
>>>>>> +       allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>>>>>> +};
>>>>>> +
>>>>>> +&ohci0 {
>>>>>> +       status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&pio {
>>>>>> +       mmc0_cd_pin_parrot: mmc0_cd_pin at 0 {
>>>>>
>>>>> _parrot suffix works as well.
>>>>>
>>>>>> +               allwinner,pins = "PD14";
>>>>>> +               allwinner,function = "gpio_in";
>>>>>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>>>>> +               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>>>>>> +       };
>>>>>> +
>>>>>> +       led_pins_r16: led_pins at 0 {
>>>>>> +               allwinner,pins = "PE16", "PE17";
>>>>>> +               allwinner,function = "gpio_out";
>>>>>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>>>>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>>>>> +       };
>>>>>> +
>>>>>> +       usb0_id_det: usb0_id_detect_pin at 0 {
>>>>>> +               allwinner,pins = "PD10";
>>>>>> +               allwinner,function = "gpio_in";
>>>>>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>>>>> +               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>>>>>> +       };
>>>>>> +
>>>>>> +       usb1_vbus_pin_r16: usb1_vbus_pin at 0 {
>>>>>> +               allwinner,pins = "PD12";
>>>>>> +               allwinner,function = "gpio_out";
>>>>>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>>>>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>>>>> +       };
>>>>>> +};
>>>>>> +
>>>>>> +&r_pio {
>>>>>> +       wifi_reset_pin_r16: wifi_reset_pin at 3 {
>>>>>
>>>>> Why @3?
>>>>>
>>>>
>>>> This is a typo, I'll correct it.
>>>>
>>>>>> +               allwinner,pins = "PL6";
>>>>>> +               allwinner,function = "gpio_out";
>>>>>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>>>>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>>>>> +       };
>>>>>> +};
>>>>>> +
>>>>>> +&r_rsb {
>>>>>> +       status = "okay";
>>>>>> +
>>>>>> +       axp22x: pmic at 3a3 {
>>>>>> +               compatible = "x-powers,axp223";
>>>>>> +               reg = <0x3a3>;
>>>>>> +               interrupt-parent = <&nmi_intc>;
>>>>>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>>>>> +               eldoin-supply = <&reg_dcdc1>;
>>>>>
>>>>> A drivevbus-supply referencing reg_vcc5v0 here would be better.
>>>>>
>>>>
>>>> ACK.
>>>>
>>>>>> +               x-powers,drive-vbus-en;
>>>>>> +       };
>>>>>> +};
>>>>>> +
>>>>>> +#include "axp22x.dtsi"
>>>>>> +
>>>>>> +&reg_aldo1 {
>>>>>> +       regulator-always-on;
>>>>>> +       regulator-min-microvolt = <3000000>;
>>>>>> +       regulator-max-microvolt = <3000000>;
>>>>>> +       regulator-name = "aldo1";
>>>>>
>>>>> What is this for exactly? Would turning it off render the system inoperable?
>>>>> How was it referenced in the fex file?
>>>>>
>>>>> If this is for WiFi I/O VCC, then you should specify it in mmc1 with
>>>>> vqmmc-supply.
>>>>>
>>>>
>>>> In the fex, aldo1 is one of the three power inputs for the WiFi (the
>>>> others being dldo1 and dldo2) and in the schematics it is linked to
>>>> both VCC-USB and VCC-IO-WIFI.
>>>>
>>>> I tried to turn it off and, indeed, the system becomes inoperable.
>>>>
>>>> I'll add vqmmc-supply in mmc1 with aldo1 regulator. However, I am
>>>> wondering what to put in vmmc-supply for mmc1 since the WiFi module has
>>>> three power inputs: dldo1, dldo2 and aldo1. In the fex, they are
>>>> referenced as, respectively, module_power1, module_power2 and
>>>> module_power3 and in the schematics dldo1 and dldo2 are named VCC-WIFI
>>>> while aldo1 is used for VCC-IO-WIFI (if it can help in any way).
>>>>
>>>> VCC-WIFI is connected to pin VBAT of the Broadcom AP6212 WiFi chip.
>>>> VCC-IO-WIFI is connected to pin VDDIO of the chip.
>>>
>>> VCC-IO-WIFI is vqmmc, and VCC-WIFI is vmmc.
>>
>> Isn't vmmc supposed to be always powered at 3.3v, and vqmmc the one
>> used to drop to 1.8V with the UHS cards?
>
> For eMMC, vmmc and vqmmc correspond to the pins on the eMMC chip.
> vmmc provides power to the internals, while vqmmc provides power to the
> I/O buffers on both sides. With SD this is a bit less clear. IIUC the SD
> card itself supplies I/O voltage, dropping it to 1.8V if necessary, from
> VDD (vmmc). vqmmc only affects the host side, and whatever external pull-ups
> that might exist.
>
>> In which case, VCC-IO-WIFI is vmmc, and VCC-WIFI is just one of the
>> wifi chip power rail, to be handled by a power sequence.
>
> For the WiFi chip, there is a separate IO-VCC rail, which is VCC-IO-WIFI.
> This, from what I understand of the datasheet, is for I/O signaling, and
> thus vqmmc. VCC-WIFI is what powers the chip, which is what vmmc is.
>
>>> About having 2 regulators, Maxime is working on a solution. In the
>>> meantime, you could have dldo1/dldo2 always-on, and put a TODO
>>> comment on them.
>>
>> Yep.
>>
>>> Not sure about it also linked to VCC-USB though. Is VCC-USB connected
>>> to the SoC or just a trace on the board? If it's the latter, it might
>>> also be designed to work with a USB based WiFi module.
>>
>> It seems to be one of the inputs of the SoC.
>
> A33 datasheet has a "VCC-USB" power pin, which it says is "Power supply
> for the USB PHY". This should probably be tied to the USB PHY node. The
> PHY framework has a common "phy-supply" property, though I don't know if
> it works with sunxi's multiple PHY per node approach.

I just checked and this will likely appear to work, but it is not a good
idea, if we ever actually start turning phy-s off on an individual basis,
then this will cause the phy-supply to get turned off on the power_off
of the first phy. If this VCC-USB thing is shared we should probably
just add support for it to phy-sun4i-usb.c and simple enable it at
probe time and disable it at remove time.

Regards,

Hans
