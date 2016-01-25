From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 25 Jan 2016 18:03:37 +0100
Subject: [PATCH v3] ARM: dts: kirkwood: add device tree for buffalo
 linkstation ls-qvl
In-Reply-To: <1453740250-16765-1-git-send-email-rogershimizu@gmail.com> (Roger
 Shimizu's message of "Tue, 26 Jan 2016 01:44:10 +0900")
References: <1453652964-21489-1-git-send-email-rogershimizu@gmail.com>
 <1453740250-16765-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <87zivtd21i.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,
 
 On lun., janv. 25 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:

> From: Mario Lange <mario_lange@gmx.net>
>
> Add dts file to support Buffalo Linkstation LS-QVL,
> which is marvell kirkwood based 4-bay 3.5" HDD NAS.
> Product info:
>   - (JPN) http://buffalo.jp/product/hdd/network/ls-qvl_r5/
>   - (ENG) http://www.buffalotech.com/products/network-storage/home-and-small-office/linkstation-pro-quad
>
> Signed-off-by: Mario Lange <mario_lange@gmx.net>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>
> Dear Kirkwood Maintainers,
>
> This is only 1 patch, so I learned that "cover letter" can be embedded here.
>
> Mario created dts for Linkstation LS-QVL, which is 4-bay NAS, based
> on my dts for 2-bay LS-WVL.
> He asked me to post the dts to ARM on hehalf of him, so here I created
> the patch set!
>
> Changes in v2:
>   - add my "Signed-off-by"
>   - fix typo in commit message
> Changes in v3:
>   - add top "From" to address Jason Cooper's suggestion
>   - add Andrew Lunn's "Reviewed-by"

Thanks for all your work, I was about to apply it but as I already
applied your previous patches I didn't manage to do it.


Would you mind rebasing your patch on the mvebu/dt branch that I have
just push on git://git.infradead.org/linux-mvebu.git ?

If not, I think I would manage to do it for you.

Thanks again,

Gregory

>
>  .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   | 135 +++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> index 0d5d0f607d6c..345db8031196 100644
> --- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> @@ -19,6 +19,7 @@ SoC. Currently known SoC compatibles are:
>  And in addition, the compatible shall be extended with the specific
>  board. Currently known boards are:
>  
> +"buffalo,linkstation-lsqvl"
>  "buffalo,linkstation-lsvl"
>  "buffalo,linkstation-lswsxl"
>  "buffalo,linkstation-lswxl"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3e2cf27d2368..68625754f398 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -183,6 +183,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-is2.dtb \
>  	kirkwood-km_kirkwood.dtb \
>  	kirkwood-laplug.dtb \
> +	kirkwood-linkstation-lsqvl.dtb \
>  	kirkwood-linkstation-lsvl.dtb \
>  	kirkwood-linkstation-lswsxl.dtb \
>  	kirkwood-linkstation-lswvl.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
> new file mode 100644
> index 000000000000..6dc0df2969f0
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
> @@ -0,0 +1,135 @@
> +/*
> + * Device Tree file for Buffalo Linkstation LS-QVL
> + *
> + * Copyright (C) 2016, Mario Lange <mario_lange@gmx.net>
> + *
> + * Based on kirkwood-linkstation-lswvl.dts,
> + * Copyright (C) 2015, 2016
> + * Roger Shimizu <rogershimizu@gmail.com>
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
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include "kirkwood-linkstation-6282.dtsi"
> +
> +/ {
> +	model = "Buffalo Linkstation LS-QVL";
> +	compatible = "buffalo,lsqvl", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> +
> +	memory { /* 256 MB */
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pin-controller at 10000 {
> +			pmx_power_hdd1: pmx-power-hdd1 {
> +				marvell,pins = "mpp9";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_hdderr0: pmx-led-hdderr0 {
> +				marvell,pins = "mpp34";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_hdderr1: pmx-led-hdderr1 {
> +				marvell,pins = "mpp35";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_hdderr2: pmx-led-hdderr2 {
> +				marvell,pins = "mpp24";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_hdderr3: pmx-led-hdderr3 {
> +				marvell,pins = "mpp25";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		sata at 80000 {
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +	gpio_leds {
> +		pinctrl-0 = <&pmx_led_function_red &pmx_led_alarm
> +			     &pmx_led_info &pmx_led_power
> +			     &pmx_led_function_blue
> +			     &pmx_led_hdderr0
> +			     &pmx_led_hdderr1
> +			     &pmx_led_hdderr2
> +			     &pmx_led_hdderr3>;
> +
> +		red-hdderr0-led {
> +			label = "linkstation:red:hdderr0";
> +			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		red-hdderr1-led {
> +			label = "linkstation:red:hdderr1";
> +			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		red-hdderr2-led {
> +			label = "linkstation:red:hdderr2";
> +			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		red-hdderr3-led {
> +			label = "linkstation:red:hdderr3";
> +			gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	regulators {
> +		pinctrl-0 = <&pmx_power_hdd0 &pmx_power_hdd1 &pmx_usb_vbus>;
> +
> +		hdd_power1: regulator at 3 {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
> +			regulator-name = "HDD1 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> -- 
> 2.1.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
