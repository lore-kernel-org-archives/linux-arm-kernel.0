From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Mon, 24 Aug 2015 09:18:00 +0200
Subject: [linux-sunxi][PATCH] ARM: sun7i: dt: Add new Olimex A20 EVB device
In-Reply-To: <CAEKpxBnQ+kCVYfE8JL5JzH5ZXb3azjwmjfAE5OXULaVm0bj2ew@mail.gmail.com>
References: <1440002596-2611-1-git-send-email-codekipper@gmail.com>
 <20150820154545.GF30520@lukather>
 <CAEKpxBnQ+kCVYfE8JL5JzH5ZXb3azjwmjfAE5OXULaVm0bj2ew@mail.gmail.com>
Message-ID: <20150824071800.GE2413@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 07:36:01AM +0200, Code Kipper wrote:
> On 20 August 2015 at 17:45, Maxime Ripard <maxime.ripard@free-electrons.com>
> wrote:
> 
> > Hi,
> >
> > On Wed, Aug 19, 2015 at 06:43:16PM +0200, codekipper at gmail.com wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > The A20-SOM-EVB is a reference design of a 2-layer board for the
> > > A20-SOM.
> > > It expands the features of A20-SOM by adding VGA connector, HDMI
> > > connector, audio In/Out, LCD connector, 2 Mpix camera, gigabit
> > > Ethernet, SATA, USB-OTG and 2 USB hosts.
> > >
> > > This patch adds basic support for the device
> > > https://www.olimex.com/Products/SOM/A20/A20-SOM-EVB/
> > >
> > > More information on the SOM can be found here
> > > http://linux-sunxi.org/Olimex_A20-SOM.
> > >
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >
> > Is there any other SOM planned that could work with that baseboard? Or
> > any other baseboard for that SOM?
>
> I've seen neither. We could always create a som.dtsi later is one emerges.

Yep. The real pain would be if there's several SOM and several
base-boards that are created.

> > > ---
> > >  arch/arm/boot/dts/Makefile                    |   1 +
> > >  arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts | 233
> > ++++++++++++++++++++++++++
> > >  2 files changed, 234 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts
> >
> Relooking at their website I can see that the device does not come under
> the olinuxino brand so maybe I should rename the dts to
> sun7i-a20-olimex-som-evb.dts

Looks good for me.

> 
> > >
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index 6d7cec1..fdbda9b 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -613,6 +613,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
> > >       sun7i-a20-olinuxino-lime.dtb \
> > >       sun7i-a20-olinuxino-lime2.dtb \
> > >       sun7i-a20-olinuxino-micro.dtb \
> > > +     sun7i-a20-olinuxino-evb.dtb \
> > >       sun7i-a20-orangepi.dtb \
> > >       sun7i-a20-orangepi-mini.dtb \
> > >       sun7i-a20-pcduino3.dtb \
> > > diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts
> > b/arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts
> > > new file mode 100644
> > > index 0000000..a0071fa
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts
> > > @@ -0,0 +1,233 @@
> > > +/*
> > > + * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>
> > > + *
> > > + * This file is dual-licensed: you can use it either under the terms
> > > + * of the GPL or the X11 license, at your option. Note that this dual
> > > + * licensing only applies to this file, and not this project as a
> > > + * whole.
> > > + *
> > > + *  a) This file is free software; you can redistribute it and/or
> > > + *     modify it under the terms of the GNU General Public License as
> > > + *     published by the Free Software Foundation; either version 2 of
> > the
> > > + *     License, or (at your option) any later version.
> > > + *
> > > + *     This file is distributed in the hope that it will be useful,
> > > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + *     GNU General Public License for more details.
> > > + *
> > > + * Or, alternatively,
> > > + *
> > > + *  b) Permission is hereby granted, free of charge, to any person
> > > + *     obtaining a copy of this software and associated documentation
> > > + *     files (the "Software"), to deal in the Software without
> > > + *     restriction, including without limitation the rights to use,
> > > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > > + *     sell copies of the Software, and to permit persons to whom the
> > > + *     Software is furnished to do so, subject to the following
> > > + *     conditions:
> > > + *
> > > + *     The above copyright notice and this permission notice shall be
> > > + *     included in all copies or substantial portions of the Software.
> > > + *
> > > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > > + *     OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "sun7i-a20.dtsi"
> > > +#include "sunxi-common-regulators.dtsi"
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +#include <dt-bindings/pinctrl/sun4i-a10.h>
> > > +
> > > +/ {
> > > +     model = "Olimex A20-OLinuXino-EVB";
> > > +     compatible = "olimex,a20-olinuxino-evb", "allwinner,sun7i-a20";
> > > +
> > > +     aliases {
> > > +             serial0 = &uart0;
> > > +     };
> > > +
> > > +     chosen {
> > > +             stdout-path = "serial0:115200n8";
> > > +     };
> > > +
> > > +     leds {
> > > +             compatible = "gpio-leds";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&led_pins_olinuxinoevb>;
> > > +
> > > +             green {
> > > +                     label = "a20-olinuxino-evb:green:usr";
> > > +                     gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
> > > +                     default-state = "on";
> > > +             };
> > > +     };
> > > +
> > > +     reg_axp_ipsout: axp_ipsout {
> > > +             compatible = "regulator-fixed";
> > > +             regulator-name = "axp-ipsout";
> > > +             regulator-min-microvolt = <5000000>;
> > > +             regulator-max-microvolt = <5000000>;
> > > +             regulator-always-on;
> > > +     };
> > > +};
> > > +
> > > +&ahci {
> > > +     target-supply = <&reg_ahci_5v>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&ehci0 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&ehci1 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&gmac {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&gmac_pins_rgmii_a>;
> > > +     phy = <&phy1>;
> > > +     phy-mode = "rgmii";
> > > +     status = "okay";
> > > +
> > > +     phy1: ethernet-phy at 1 {
> > > +             reg = <1>;
> > > +     };
> > > +};
> > > +
> > > +&i2c0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&i2c0_pins_a>;
> > > +     status = "okay";
> > > +
> > > +     axp209: pmic at 34 {
> > > +             compatible = "x-powers,axp209";
> > > +             reg = <0x34>;
> > > +             interrupt-parent = <&nmi_intc>;
> > > +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             interrupt-controller;
> > > +             #interrupt-cells = <1>;
> > > +
> > > +             acin-supply = <&reg_axp_ipsout>;
> > > +             vin2-supply = <&reg_axp_ipsout>;
> > > +             vin3-supply = <&reg_axp_ipsout>;
> > > +             ldo24in-supply = <&reg_axp_ipsout>;
> > > +             ldo3in-supply = <&reg_axp_ipsout>;
> >
> > Please use the axp209 dtsi.
> >
> Will do
> 
> >
> > > +
> > > +             regulators {
> > > +                     vdd_rtc: ldo1 {
> > > +                             regulator-min-microvolt = <1300000>;
> > > +                             regulator-max-microvolt = <1300000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     avcc: ldo2 {
> > > +                             regulator-min-microvolt = <1800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vcc_csi0: ldo3 {
> > > +                             regulator-min-microvolt = <700000>;
> > > +                             regulator-max-microvolt = <3500000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vcc_csi1: ldo4 {
> > > +                             regulator-min-microvolt = <1250000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-always-on;
> > > +                     };
> >
> > the csi regulators are always-on too? What function do they provide?
> >
> This was a c & p from the lime 2 dts as their fex files are very similar. I
> can remove this for now.

Please do. And if it does make the board unstable, then it's probably
not the CSI regulator.

> > > +                     vdd_cpu: dcdc2 {
> > > +                             regulator-min-microvolt = <700000>;
> > > +                             regulator-max-microvolt = <2275000>;
> >
> > This is way outside of the CPU operating range. Are you sure of your
> > constraints?
>
> ditto. I will check on this.

Remember, constraints are not the boundaries of what the PMIC can
provide, but what the components on the other end can accept.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150824/fb181a7a/attachment-0001.sig>
