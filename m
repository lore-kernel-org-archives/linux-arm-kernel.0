From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 01 Dec 2015 18:19:47 +0100
Subject: [PATCH 3/3] ARM: dts: rockchip: add veyron-minnie board
In-Reply-To: <2008536.lEUHWtryIT@diego>
References: <2767415.mEkgRbSSUB@diego> <2008536.lEUHWtryIT@diego>
Message-ID: <1851502.mTag78mHRJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't have much luck with patches today ... obviously that is supposed to be 
mickey in the subject

Am Dienstag, 1. Dezember 2015, 18:16:55 schrieb Heiko St?bner:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> Also known as the Asus Chromebit.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
> ---
> would cool to get an Ack from ChromeOS-people concerning the
> license change to GPL2/X11 - as with the dts before
> 
> Also if someone else should be designated as author I would be happy
> got get a shout about that :-) . I did take Chris as he was the one
> submitting the initial mickey dts to the chromeos tree.
> 
> And of course it would be cool if anyone could test that on an actual
> mickey device.
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   9 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/rk3288-veyron-mickey.dts         | 246
> +++++++++++++++++++++ 3 files changed, 256 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-veyron-mickey.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> b/Documentation/devicetree/bindings/arm/rockchip.txt index 2f8b35a..2fa0a21
> 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -54,6 +54,15 @@ Rockchip platforms device tree bindings
>  		     "google,veyron-jerry-rev3", "google,veyron-jerry",
>  		     "google,veyron", "rockchip,rk3288";
> 
> +- Google Mickey (Asus Chromebit CS10):
> +    Required root node properties:
> +      - compatible = "google,veyron-mickey-rev8",
> "google,veyron-mickey-rev7", +		     "google,veyron-mickey-rev6",
> "google,veyron-mickey-rev5",
> +		     "google,veyron-mickey-rev4", "google,veyron-mickey-rev3",
> +		     "google,veyron-mickey-rev2", "google,veyron-mickey-rev1",
> +		     "google,veyron-mickey-rev0", "google,veyron-mickey",
> +		     "google,veyron", "rockchip,rk3288";
> +
>  - Google Minnie (Asus Chromebook Flip C100P):
>      Required root node properties:
>        - compatible = "google,veyron-minnie-rev4",
> "google,veyron-minnie-rev3", diff --git a/arch/arm/boot/dts/Makefile
> b/arch/arm/boot/dts/Makefile index 2f29350..8b49bfc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -527,6 +527,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3288-veyron-brain.dtb \
>  	rk3288-veyron-jaq.dtb \
>  	rk3288-veyron-jerry.dtb \
> +	rk3288-veyron-mickey.dtb \
>  	rk3288-veyron-minnie.dtb \
>  	rk3288-veyron-pinky.dtb \
>  	rk3288-veyron-speedy.dtb
> diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> b/arch/arm/boot/dts/rk3288-veyron-mickey.dts new file mode 100644
> index 0000000..365382a
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> @@ -0,0 +1,246 @@
> +/*
> + * Google Veyron Mickey Rev 0 board device tree source
> + *
> + * Copyright 2015 Google, Inc
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
> + *  Or, alternatively,
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
> +#include "rk3288-veyron.dtsi"
> +
> +/ {
> +	model = "Google Mickey";
> +	compatible = "google,veyron-mickey-rev8", "google,veyron-mickey-rev7",
> +		     "google,veyron-mickey-rev6", "google,veyron-mickey-rev5",
> +		     "google,veyron-mickey-rev4", "google,veyron-mickey-rev3",
> +		     "google,veyron-mickey-rev2", "google,veyron-mickey-rev1",
> +		     "google,veyron-mickey-rev0", "google,veyron-mickey",
> +		     "google,veyron", "rockchip,rk3288";
> +
> +	vcc_5v: vcc-5v {
> +		vin-supply = <&vcc33_sys>;
> +	};
> +
> +	vcc33_io: vcc33_io {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc33_io";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc33_sys>;
> +	};
> +};
> +
> +&cpu_thermal {
> +	/delete-node/ trips;
> +	/delete-node/ cooling-maps;
> +
> +	trips {
> +		cpu_alert_almost_warm: cpu_alert_almost_warm {
> +			temperature = <63000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "passive";
> +		};
> +		cpu_alert_warm: cpu_alert_warm {
> +			temperature = <65000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "passive";
> +		};
> +		cpu_alert_almost_hot: cpu_alert_almost_hot {
> +			temperature = <80000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "passive";
> +		};
> +		cpu_alert_hot: cpu_alert_hot {
> +			temperature = <82000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "passive";
> +		};
> +		cpu_alert_hotter: cpu_alert_hotter {
> +			temperature = <84000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "passive";
> +		};
> +		cpu_alert_very_hot: cpu_alert_very_hot {
> +			temperature = <85000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "passive";
> +		};
> +		cpu_crit: cpu_crit {
> +			temperature = <90000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "critical";
> +		};
> +	};
> +
> +	cooling-maps {
> +		/*
> +		 * After 1st level, throttle the CPU down to as low as 1.4 GHz
> +		 * and don't let the GPU go faster than 400 MHz.  Note that we
> +		 * won't throttle the GPU lower than 400 MHz due to CPU
> +		 * heat--we'll let the GPU do the rest itself.
> +		 */
> +		cpu_warm_limit_cpu {
> +			trip = <&cpu_alert_warm>;
> +			cooling-device =
> +				<&cpu0 THERMAL_NO_LIMIT 4>;
> +		};
> +
> +		/*
> +		 * Add some discrete steps to help throttling system deal
> +		 * with the fact that there are two passive cooling devices:
> +		 * the CPU and the GPU.
> +		 *
> +		 * - 1.2 GHz - 1.0 GHz (almost hot)
> +		 * - 800 MHz           (hot)
> +		 * - 800 MHz - 696 MHz (hotter)
> +		 * - 696 MHz - min     (very hot)
> +		 *
> +		 * Note:
> +		 * - 800 MHz appears to be a "sweet spot" for me.  I can run
> +		 *   some pretty serious workload here and be happy.
> +		 * - After 696 MHz we stop lowering voltage, so throttling
> +		 *   past there is less effective.
> +		 */
> +		cpu_almost_hot_limit_cpu {
> +			trip = <&cpu_alert_almost_hot>;
> +			cooling-device =
> +				<&cpu0 5 6>;
> +		};
> +		cpu_hot_limit_cpu {
> +			trip = <&cpu_alert_hot>;
> +			cooling-device =
> +				<&cpu0 7 7>;
> +		};
> +		cpu_hotter_limit_cpu {
> +			trip = <&cpu_alert_hotter>;
> +			cooling-device =
> +				<&cpu0 7 8>;
> +		};
> +		cpu_very_hot_limit_cpu {
> +			trip = <&cpu_alert_very_hot>;
> +			cooling-device =
> +				<&cpu0 8 THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c4 {
> +	status = "disabled";
> +};
> +
> +&i2s {
> +	status = "okay";
> +	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
> +	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_OUT>;
> +};
> +
> +&rk808 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
> +	dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
> +		    <&gpio7 15 GPIO_ACTIVE_HIGH>;
> +
> +	/delete-property/ vcc6-supply;
> +	/delete-property/ vcc12-supply;
> +
> +	vcc11-supply = <&vcc33_sys>;
> +
> +	regulators {
> +		/* vcc33_io is sourced directly from vcc33_sys */
> +		/delete-node/ LDO_REG1;
> +		/delete-node/ LDO_REG7;
> +
> +		/* This is not a pwren anymore, but the real power supply */
> +		vdd10_lcd: LDO_REG7 {
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-name = "vdd10_lcd";
> +			regulator-suspend-mem-disabled;
> +		};
> +
> +		vcc18_lcd: LDO_REG8 {
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-name = "vcc18_lcd";
> +			regulator-suspend-mem-disabled;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	hdmi {
> +		power_hdmi_on: power-hdmi-on {
> +			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		dvs_1: dvs-1 {
> +			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		dvs_2: dvs-2 {
> +			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +&usb_host0_ehci {
> +	status = "disabled";
> +};
> +
> +&usb_host1 {
> +	status = "disabled";
> +};
> +
> +&vcc50_hdmi {
> +	enable-active-high;
> +	gpio = <&gpio7 11 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&power_hdmi_on>;
> +};
