From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Wed, 25 Nov 2015 09:28:48 -0300
Subject: [PATCH 3/3] ARM: dts: lpc4337-ciaa: add i2c0 and devices
In-Reply-To: <1448282225-2635-4-git-send-email-ariel@vanguardiasur.com.ar>
References: <1448282225-2635-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1448282225-2635-4-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <5655A980.9000605@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+To: Joachim)

El 23/11/15 a las 09:37, Ariel D'Alessandro escribi?:
> Add I2C0 and two I2C EEPROM devices on the CIAA-NXP board:
> 
> * 24AA1025 EEPROM, 1Mbit: it is accessed as two 512Kbit EEPROMs.
> * 24AA025E48 EEPROM, 2kbit.
> 
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/lpc4337-ciaa.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
> index 1a23589..d81047a 100644
> --- a/arch/arm/boot/dts/lpc4337-ciaa.dts
> +++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
> @@ -99,6 +99,14 @@
>  		};
>  	};
>  
> +	i2c0_pins: i2c0-pins {
> +		i2c0_pins_cfg {
> +			pins = "i2c0_scl", "i2c0_sda";
> +			function = "i2c0";
> +			input-enable;
> +		};
> +	};
> +
>  	ssp_pins: ssp-pins {
>  		ssp1_cs {
>  			pins = "p6_7";
> @@ -163,6 +171,28 @@
>  	clock-frequency = <50000000>;
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	clock-frequency = <400000>;
> +
> +	eeprom at 50 {
> +		compatible = "microchip,24c512";
> +		reg = <0x50>;
> +	};
> +
> +	eeprom at 51 {
> +		compatible = "microchip,24c02";
> +		reg = <0x51>;
> +	};
> +
> +	eeprom at 54 {
> +		compatible = "microchip,24c512";
> +		reg = <0x54>;
> +	};
> +};
> +
>  &mac {
>  	status = "okay";
>  	phy-mode = "rmii";
> 

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
