From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 12 Mar 2013 17:54:18 +0100
Subject: [PATCH 2/2] arm: at91: dt: at91sam9x5: add i2c-gpio pinctrl
In-Reply-To: <1363107286-25698-2-git-send-email-richard.genoud@gmail.com>
References: <1363107286-25698-1-git-send-email-richard.genoud@gmail.com>
 <1363107286-25698-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130312165418.GD2001@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:54 Tue 12 Mar     , Richard Genoud wrote:
> i2c-gpio is sometimes used in place of i2c-at91.
> This adds the pin muxes for the gpios.

I'm more to drop the i2c gpio support as the hw work fine

Best Regards,
J.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  based on v3.9-rc2
> 
>  arch/arm/boot/dts/at91sam9x5.dtsi |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 8cbcff4..d18aff5 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -343,6 +343,30 @@
>  					};
>  				};
>  
> +				i2c_gpio0 {
> +					pinctrl_i2c_gpio0: i2c_gpio0-0 {
> +						atmel,pins =
> +							<0 30 0x0 0x2	/* PA30 gpio multidrive I2C0 data */
> +							 0 31 0x0 0x2>;	/* PA31 gpio multidrive I2C0 clock */
> +					};
> +				};
> +
> +				i2c_gpio1 {
> +					pinctrl_i2c_gpio1: i2c_gpio1-0 {
> +						atmel,pins =
> +							<2 0 0x0 0x2	/* PC0 gpio multidrive I2C1 data */
> +							 2 1 0x0 0x2>;	/* PC1 gpio multidrive I2C1 clock */
> +					};
> +				};
> +
> +				i2c_gpio2 {
> +					pinctrl_i2c_gpio2: i2c_gpio2-0 {
> +						atmel,pins =
> +							<1 4 0x0 0x2	/* PB4 gpio multidrive I2C2 data */
> +							 1 5 0x0 0x2>;	/* PB5 gpio multidrive I2C2 clock */
> +					};
> +				};
> +
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> @@ -583,6 +607,8 @@
>  		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2c_gpio0>;
>  		status = "disabled";
>  	};
>  
> @@ -596,6 +622,8 @@
>  		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2c_gpio1>;
>  		status = "disabled";
>  	};
>  
> @@ -609,6 +637,8 @@
>  		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2c_gpio2>;
>  		status = "disabled";
>  	};
>  };
> -- 
> 1.7.2.5
> 
