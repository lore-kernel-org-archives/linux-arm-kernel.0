From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 13:41:30 -0800
Subject: [PATCH v2] arm, am335x: add support for the bosch shc board
In-Reply-To: <1447748655-2088-1-git-send-email-hs@denx.de>
References: <1447748655-2088-1-git-send-email-hs@denx.de>
Message-ID: <20151130214130.GA23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Heiko Schocher <hs@denx.de> [151117 00:25]:
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-shc.dts
> +&tps {
> +	compatible = "ti,tps65217";
> +	ti,pmic-shutdown-controller;
> +
> +	regulators {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dcdc1_reg: regulator at 0 {
> +			reg = <0>;
> +			regulator-name = "vdds_dpr";
> +			regulator-compatible = "dcdc1";
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1450000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		dcdc2_reg: regulator at 1 {
> +			reg = <1>;
> +			/*
> +			 * VDD_MPU voltage limits 0.95V - 1.26V with
> +			 * +/-4% tolerance
> +			 */
> +			regulator-compatible = "dcdc2";
> +			regulator-name = "vdd_mpu";
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <1375000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +			regulator-ramp-delay = <70000>;
> +		};
> +
> +		dcdc3_reg: regulator at 2 {
> +			reg = <2>;
> +			/*
> +			 * VDD_CORE voltage limits 0.95V - 1.1V with
> +			 * +/-4% tolerance
> +			 */
> +			regulator-name = "vdd_core";
> +			regulator-compatible = "dcdc3";
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <1125000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		ldo1_reg: regulator at 3 {
> +			reg = <3>;
> +			regulator-name = "vio,vrtc,vdds";
> +			regulator-compatible = "ldo1";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		ldo2_reg: regulator at 4 {
> +			reg = <4>;
> +			regulator-name = "vdd_3v3aux";
> +			regulator-compatible = "ldo2";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		ldo3_reg: regulator at 5 {
> +			reg = <5>;
> +			regulator-name = "vdd_1v8";
> +			regulator-compatible = "ldo3";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		ldo4_reg: regulator at 6 {
> +			reg = <6>;
> +			regulator-name = "vdd_3v3a";
> +			regulator-compatible = "ldo4";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +};

Applying this into omap-for-v4.5/dt.. But I'm getting concerned about this
"regulator-always-on" stuff and having multiple copies of the same thing.

I think we should have a common am33xx-tps65217.dtsi file that has the
regulators defined at one place and other then include it. And they are
controllable AFAIK..

Regards,

Tony
