From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 May 2015 08:38:22 -0700
Subject: [PATCH] arm: dts: Beaglebone i2c definitions
In-Reply-To: <1431504274-32084-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1431504274-32084-1-git-send-email-pantelis.antoniou@konsulko.com>
Message-ID: <20150514153822.GJ15563@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150513 01:05]:
> The beaglebone family of boards contain two I2C busses enabled.
> The first one with a baseboard identification EEPROM and a
> cape I2C bus.

This seems safe to apply as the i2c2 pins are listed in the cape
specification.

These pins could be used for other devices too.. But in that case
the cape would not follow the cape standard.

Regards,

Tony
 
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 66 +++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index c3255e0..236b7db 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -81,6 +81,13 @@
>  		>;
>  	};
>  
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins = <
> +			0x178 (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
> +			0x17c (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
> +		>;
> +	};
> +
>  	uart0_pins: pinmux_uart0_pins {
>  		pinctrl-single,pins = <
>  			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
> @@ -218,8 +225,67 @@
>  		reg = <0x24>;
>  	};
>  
> +	baseboard_eeprom: baseboard_eeprom at 50 {
> +		compatible = "at,24c256";
> +		reg = <0x50>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		baseboard_data: baseboard_data at 0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	cape_eeprom0: cape_eeprom0 at 54 {
> +		compatible = "at,24c256";
> +		reg = <0x54>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape0_data: cape_data at 0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +
> +	cape_eeprom1: cape_eeprom1 at 55 {
> +		compatible = "at,24c256";
> +		reg = <0x55>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape1_data: cape_data at 0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +
> +	cape_eeprom2: cape_eeprom2 at 56 {
> +		compatible = "at,24c256";
> +		reg = <0x56>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape2_data: cape_data at 0 {
> +			reg = <0 0x100>;
> +		};
> +	};
> +
> +	cape_eeprom3: cape_eeprom3 at 57 {
> +		compatible = "at,24c256";
> +		reg = <0x57>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cape3_data: cape_data at 0 {
> +			reg = <0 0x100>;
> +		};
> +	};
>  };
>  
> +
>  /include/ "tps65217.dtsi"
>  
>  &tps {
> -- 
> 1.7.12
> 
