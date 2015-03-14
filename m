From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 14 Mar 2015 16:37:03 +0800
Subject: [linux-sunxi] [PATCH v3 3/3] ARM: dts: sun6i: Add dts file for
 CSQ CS908 board
In-Reply-To: <1419851366-21945-3-git-send-email-hdegoede@redhat.com>
References: <1419851366-21945-1-git-send-email-hdegoede@redhat.com>
 <1419851366-21945-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66si8Kia2E_t+XaXYRPbjbruww8Xoo=6a9kibbSzXPRbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for digging through old patches.

On Mon, Dec 29, 2014 at 7:09 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The CSQ CS908 is an A31s based top-set box, with 1G RAM, 8G NAND,
> rtl8188etv usb wifi, 2 USB A receptacles (1 connected through the OTG
> controller), ethernet, 3.5 mm jack with a/v out and hdmi out.
>
> Note it has no sdcard slot and therefore can only be fel booted.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Drop URL from commit message, it is likely to go stale
> Changes in v3:
> -Do not duplicate the DT path, use label references instead
> ---
>  arch/arm/boot/dts/Makefile             |   3 +-
>  arch/arm/boot/dts/sun6i-a31s-cs908.dts | 102 +++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun6i-a31s-cs908.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 803e914..a86f232 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -462,7 +462,8 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>         sun6i-a31-app4-evb1.dtb \
>         sun6i-a31-colombus.dtb \
>         sun6i-a31-hummingbird.dtb \
> -       sun6i-a31-m9.dtb
> +       sun6i-a31-m9.dtb \
> +       sun6i-a31s-cs908.dtb
>  dtb-$(CONFIG_MACH_SUN7I) += \
>         sun7i-a20-bananapi.dtb \
>         sun7i-a20-cubieboard2.dtb \
> diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
> new file mode 100644
> index 0000000..491aa83
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
> @@ -0,0 +1,102 @@
> +/*
> + * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this library; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +/include/ "sun6i-a31s.dtsi"
> +
> +/ {
> +       model = "CSQ CS908 top set box";
> +       compatible = "csq,cs908", "allwinner,sun6i-a31s";
> +};
> +
> +&usbphy {
> +       status = "okay";
> +};
> +
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&ohci1 {
> +       status = "okay";
> +};
> +
> +&pio {
> +       usb1_vbus_pin_csq908: usb1_vbus_pin at 0 {
> +               allwinner,pins = "PC27";
> +               allwinner,function = "gpio_out";
> +               allwinner,drive = <0>;
> +               allwinner,pull = <0>;
> +       };

This isn't used anywhere. Hans, did you miss something when
converting to label references?

ChenYu

> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pins_a>;
> +       status = "okay";
> +};
> +
> +&gmac {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&gmac_pins_mii_a>;
> +       phy = <&phy1>;
> +       phy-mode = "mii";
> +       status = "okay";
> +       phy1: ethernet-phy at 1 {
> +               reg = <1>;
> +       };
> +};
> +
> +&ir {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&ir_pins_a>;
> +       status = "okay";
> +};
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
