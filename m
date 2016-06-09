From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Jun 2016 09:21:12 +0800
Subject: [PATCH V2 4/4] ARM: mxs: dts: Add SanDisk Sansa Fuze+ support
In-Reply-To: <1462740621-7557-4-git-send-email-marex@denx.de>
References: <1462740621-7557-1-git-send-email-marex@denx.de>
 <1462740621-7557-4-git-send-email-marex@denx.de>
Message-ID: <20160609012112.GA15053@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2016 at 10:50:21PM +0200, Marek Vasut wrote:
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_vddio_sd0: vddio-sd0 {

Put fixed regulator nodes directly under root with suggested naming
scheme.

> +			compatible = "regulator-fixed";
> +			regulator-name = "vddio-sd0";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio0 8 0>;
> +		};
> +
> +		reg_vddio_sd1: vddio-sd1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vddio-sd1";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio1 29 0>;
> +		};
> +
> +		reg_vdd_touchpad: vdd-touchpad0 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vdd-touchpad0";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio0 26 0>;
> +			regulator-always-on;
> +			enable-active-low;
> +		};
> +
> +		reg_vdd_tuner: vdd-tuner0 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vdd-tuner0";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio0 29 0>;
> +			regulator-always-on;
> +			enable-active-low;
> +		};
> +	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 2 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +	};
> +
> +	i2c at 0 {

The @unit-address should be used for nodes with 'reg' property.

Shawn

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "i2c-gpio";
> +		gpios = <
> +			&gpio1 24 0		/* SDA */
> +			&gpio1 22 0		/* SCL */
> +		>;
> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> +	};
> +
> +	i2c at 1 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "i2c-gpio";
> +		gpios = <
> +			&gpio0 31 0		/* SDA */
> +			&gpio0 30 0		/* SCL */
> +		>;
> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> +
> +		touch: touch at 20 {
> +			compatible = "synaptics,synaptics_i2c";
> +			reg = <0x20>;
> +		};
> +
> +		eeprom: eeprom at 50 {
> +			compatible = "atmel,24c64";
> +			reg = <0x50>;
> +			pagesize = <32>;
> +		};
> +	};
> +
> +};
> -- 
> 2.7.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
