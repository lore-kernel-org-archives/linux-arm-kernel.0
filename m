From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 29 Jun 2015 15:22:56 +0200
Subject: [PATCH v2 2/2] ARM: dts: add buffalo linkstation ls-wvl/vl
In-Reply-To: <1434985351-6678-1-git-send-email-rogershimizu@gmail.com>
References: <1434713319-8691-3-git-send-email-rogershimizu@gmail.com>
 <1434985351-6678-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <559146B0.1010905@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 22/06/2015 17:02, Roger Shimizu wrote:
> Add dts file to support Buffalo Linkstation LS-WVL and LS-VL,
> which are 3.5" HDD NAS in 2-bay and 1-bay respectively.
> 
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> Reviewed-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

it seems that you addressed Andrew's remarks too, so

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


However I will wait for Andrew's formal acked-by before applying it.

Thanks,

Gregory


> ---
>  .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/kirkwood-lswvl.dts               | 301 +++++++++++++++++++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-lswvl.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> index b79212f..5171ad8 100644
> --- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> @@ -20,6 +20,7 @@ And in addition, the compatible shall be extended with the specific
>  board. Currently known boards are:
>  
>  "buffalo,lschlv2"
> +"buffalo,lswvl"
>  "buffalo,lswxl"
>  "buffalo,lsxhl"
>  "buffalo,lsxl"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b45c974..5b36795 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -176,6 +176,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-km_kirkwood.dtb \
>  	kirkwood-laplug.dtb \
>  	kirkwood-lschlv2.dtb \
> +	kirkwood-lswvl.dtb \
>  	kirkwood-lswxl.dtb \
>  	kirkwood-lsxhl.dtb \
>  	kirkwood-mplcec4.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-lswvl.dts b/arch/arm/boot/dts/kirkwood-lswvl.dts
> new file mode 100644
> index 0000000..ad35329
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-lswvl.dts
> @@ -0,0 +1,301 @@
> +/*
> + * Device Tree file for Buffalo Linkstation LS-WVL/VL
> + *
> + * Copyright (C) 2015, rogershimizu at gmail.com
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6282.dtsi"
> +
> +/ {
> +	model = "Buffalo Linkstation LS-WVL/VL";
> +	compatible = "buffalo,lswvl", "buffalo,lsvl", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> +
> +	memory { /* 256 MB */
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +		stdout-path = &uart0;
> +	};
> +
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pin-controller at 10000 {
> +			pmx_power_hdd0: pmx-power-hdd0 {
> +				marvell,pins = "mpp8";
> +				marvell,function = "gpio";
> +			};
> +			pmx_power_hdd1: pmx-power-hdd1 {
> +				marvell,pins = "mpp9";
> +				marvell,function = "gpio";
> +			};
> +			pmx_usb_vbus: pmx-usb-vbus {
> +				marvell,pins = "mpp12";
> +				marvell,function = "gpio";
> +			};
> +			pmx_fan_high: pmx-fan-high {
> +				marvell,pins = "mpp16";
> +				marvell,function = "gpio";
> +			};
> +			pmx_fan_low: pmx-fan-low {
> +				marvell,pins = "mpp17";
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
> +			pmx_led_alarm: pmx-led-alarm {
> +				marvell,pins = "mpp36";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_function_red: pmx-led-function_red {
> +				marvell,pins = "mpp37";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_info: pmx-led-info {
> +				marvell,pins = "mpp38";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_function_blue: pmx-led-function-blue {
> +				marvell,pins = "mpp39";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_power: pmx-led-power {
> +				marvell,pins = "mpp40";
> +				marvell,function = "gpio";
> +			};
> +			pmx_fan_lock: pmx-fan-lock {
> +				marvell,pins = "mpp43";
> +				marvell,function = "gpio";
> +			};
> +			pmx_button_function: pmx-button-function {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +			pmx_power_switch: pmx-power-switch {
> +				marvell,pins = "mpp46";
> +				marvell,function = "gpio";
> +			};
> +			pmx_power_auto_switch: pmx-power-auto-switch {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		serial at 12000 {
> +			status = "okay";
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +
> +			m25p40 at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "st,m25p40", "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <25000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x60000>;
> +					label = "uboot";
> +					read-only;
> +				};
> +
> +				partition at 60000 {
> +					reg = <0x60000 0x10000>;
> +					label = "dtb";
> +					read-only;
> +				};
> +
> +				partition at 70000 {
> +					reg = <0x70000 0x10000>;
> +					label = "uboot_env";
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_button_function &pmx_power_switch
> +			     &pmx_power_auto_switch>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Function Button";
> +			linux,code = <KEY_OPTION>;
> +			gpios = <&gpio0 45 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button at 2 {
> +			label = "Power-on Switch";
> +			linux,code = <KEY_RESERVED>;
> +			linux,input-type = <5>;
> +			gpios = <&gpio0 46 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button at 3 {
> +			label = "Power-auto Switch";
> +			linux,code = <KEY_ESC>;
> +			linux,input-type = <5>;
> +			gpios = <&gpio0 47 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio_leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_led_function_red &pmx_led_alarm
> +			     &pmx_led_info &pmx_led_power
> +			     &pmx_led_function_blue
> +			     &pmx_led_hdderr0
> +			     &pmx_led_hdderr1>;
> +		pinctrl-names = "default";
> +
> +		led at 1 {
> +			label = "lswvl:red:alarm";
> +			gpios = <&gpio0 36 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led at 2 {
> +			label = "lswvl:red:func";
> +			gpios = <&gpio0 37 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led at 3 {
> +			label = "lswvl:amber:info";
> +			gpios = <&gpio0 38 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led at 4 {
> +			label = "lswvl:blue:func";
> +			gpios = <&gpio0 39 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led at 5 {
> +			label = "lswvl:blue:power";
> +			gpios = <&gpio0 40 GPIO_ACTIVE_LOW>;
> +			default-state = "keep";
> +		};
> +
> +		led at 6 {
> +			label = "lswvl:red:hdderr0";
> +			gpios = <&gpio0 34 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led at 7 {
> +			label = "lswvl:red:hdderr1";
> +			gpios = <&gpio0 35 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio_fan {
> +		compatible = "gpio-fan";
> +		pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
> +		pinctrl-names = "default";
> +
> +		gpios = <&gpio0 17 GPIO_ACTIVE_LOW
> +			 &gpio0 16 GPIO_ACTIVE_LOW>;
> +
> +		gpio-fan,speed-map = <0 3
> +				1500 2
> +				3250 1
> +				5000 0>;
> +
> +		alarm-gpios = <&gpio0 43 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	restart_poweroff {
> +		compatible = "restart-poweroff";
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_power_hdd0 &pmx_power_hdd1 &pmx_usb_vbus>;
> +		pinctrl-names = "default";
> +
> +		usb_power: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "USB Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +		};
> +		hdd_power0: regulator at 2 {
> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +			regulator-name = "HDD0 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 8 GPIO_ACTIVE_HIGH>;
> +		};
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
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		device_type = "ethernet-phy";
> +		reg = <0>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
