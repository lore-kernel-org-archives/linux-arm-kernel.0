From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 13 Mar 2013 11:07:35 +0100
Subject: [PATCH 1/2] arm: at91: dt: at91sam9x5: add i2c pinctrl
In-Reply-To: <1363107286-25698-1-git-send-email-richard.genoud@gmail.com>
References: <1363107286-25698-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130313100735.GA9249@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 05:54:45PM +0100, Richard Genoud wrote:
> This adds the at19 i2c controller pin muxes for at91sam9x5 based boards.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  based on v3.9-rc2
> 
>  arch/arm/boot/dts/at91sam9x5.dtsi |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index aa98e64..8cbcff4 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -319,6 +319,30 @@
>  					};
>  				};
>  
> +				i2c0 {
> +					pinctrl_i2c0: i2c0-0 {
> +						atmel,pins =
> +							<0 30 0x1 0x0	/* PA30 periph A I2C0 data */
> +							 0 31 0x1 0x0>;	/* PA31 periph A I2C0 clock */
> +					};
> +				};
> +
> +				i2c1 {
> +					pinctrl_i2c1: i2c1-0 {
> +						atmel,pins =
> +							<2 0 0x3 0x0	/* PC0 periph C I2C1 data */
> +							 2 1 0x3 0x0>;	/* PC1 periph C I2C1 clock */
> +					};
> +				};
> +
> +				i2c2 {
> +					pinctrl_i2c2: i2c2-0 {
> +						atmel,pins =
> +							<1 4 0x2 0x0	/* PB4 periph B I2C2 data */
> +							 1 5 0x2 0x0>;	/* PB5 periph B I2C2 clock */
> +					};
> +				};
> +
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> @@ -447,6 +471,8 @@
>  				interrupts = <9 4 6>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c0>;
>  				status = "disabled";
>  			};
>  
> @@ -456,6 +482,8 @@
>  				interrupts = <10 4 6>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c1>;
>  				status = "disabled";
>  			};
>  
> @@ -465,6 +493,8 @@
>  				interrupts = <11 4 6>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c2>;
>  				status = "disabled";
>  			};
>  
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
