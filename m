From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Jan 2015 22:22:03 +0100
Subject: [PATCH] ARM: dts: sun4i: Add initial dts for Gemei G9 tablet
In-Reply-To: <1422045409-1251-1-git-send-email-plaes@plaes.org>
References: <1422045409-1251-1-git-send-email-plaes@plaes.org>
Message-ID: <20150123212203.GB8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 10:36:49PM +0200, Priit Laes wrote:
> Gemei G9 is an A10 based tablet, with 1G RAM, 16G NAND, 1024x768
> IPS LCD display, stereo speakers, 1.3MP front camera and 5 MP
> rear camera, 8000mAh battery, GT901 2+1 touchscreen, Bosch BMA250
> accelerometer and RTL8188CUS USB wifi. It also has MicroSD slot,
> miniHDMI, 1 x MicroUSB OTG port and 1 x MicroUSB host port and
> 3.5mm headphone jack.
> More details are available at: http://linux-sunxi.org/Gemei_G9
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/Makefile               |   6 +-
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 138 +++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7df26a2..a2e05fc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -447,12 +447,14 @@ dtb-$(CONFIG_MACH_SUN4I) += \
>  	sun4i-a10-ba10-tvbox.dtb \
>  	sun4i-a10-chuwi-v7-cw0825.dtb \
>  	sun4i-a10-cubieboard.dtb \
> +	sun4i-a10-gemei-g9.dtb \
> +	sun4i-a10-hackberry.dtb \
> +	sun4i-a10-inet97fv2.dtb \
>  	sun4i-a10-marsboard.dtb \
>  	sun4i-a10-mini-xplus.dtb \
>  	sun4i-a10-mk802.dtb \
>  	sun4i-a10-mk802ii.dtb \
> -	sun4i-a10-hackberry.dtb \
> -	sun4i-a10-inet97fv2.dtb \
> +	sun4i-a10-mini-xplus.dtb \
>  	sun4i-a10-olinuxino-lime.dtb \
>  	sun4i-a10-pcduino.dtb
>  dtb-$(CONFIG_MACH_SUN5I) += \
> diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> new file mode 100644
> index 0000000..46700b8
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright 2015 Priit Laes
> + *
> + * Priit Laes <plaes@plaes.org>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
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
> +#include "sun4i-a10.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +    model = "Gemei G9 Tablet";
> +    compatible = "gemei,g9", "allwinner,sun4i-a10";
> +};
> +
> +/*
> + * http://linux-sunxi.org/Gemei_G9

Please don't put URL in the DT. This is very likely to change in the
future, and won't be valid anymore.

> + *
> + * TODO:
> + *   2x cameras via CSI
> + *   AXP battery management
> + *   AXP power enable key
> + *   Keys (LRADC)
> + *   NAND
> + *   OTG
> + *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
> + */
> +
> +
> +&ehci0 {
> +    status = "okay";
> +};

Indentation with one tabulation please.


> +&ehci1 {
> +    status = "okay";
> +};
> +
> +&i2c0 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&i2c0_pins_a>;
> +    status = "okay";
> +
> +    axp209: pmic at 34 {
> +        compatible = "x-powers,axp209";
> +        reg = <0x34>;
> +        interrupts = <0>;
> +
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +    };
> +};
> +
> +&i2c1 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&i2c1_pins_a>;
> +    status = "okay";
> +
> +    /* Accelerometer */
> +    bma250 at 18 {
> +        compatible = "bosch,bma250";
> +        reg = <0x18>;

Is there a driver for this? It looks weird that it doesn't need more
properties than that.

> +    };
> +};
> +
> +&reg_usb1_vbus {
> +    status = "okay";
> +};
> +
> +&reg_usb2_vbus {
> +    status = "okay";
> +};
> +
> +&mmc0 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +    vmmc-supply = <&reg_vcc3v3>;
> +    bus-width = <4>;
> +    cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH01 */
> +    cd-inverted;
> +    status = "okay";
> +};
> +
> +

Remove that extra new line.

> +&uart0  {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&uart0_pins_a>;
> +    status = "okay";
> +};
> +
> +&usbphy {
> +    usb1_vbus-supply = <&reg_usb1_vbus>;
> +    usb2_vbus-supply = <&reg_usb2_vbus>;
> +    status = "okay";
> +};
> -- 
> 2.2.2
> 

Looks good otherwise, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150123/444dc7c1/attachment-0001.sig>
