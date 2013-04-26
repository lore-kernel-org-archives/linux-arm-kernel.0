From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 26 Apr 2013 07:48:51 +0000
Subject: linux-next: manual merge of the arm-soc tree with the spi-mb tree
In-Reply-To: <20130426170649.d21c2d7a74e56d836ff6f04f@canb.auug.org.au>
References: <20130426170649.d21c2d7a74e56d836ff6f04f@canb.auug.org.au>
Message-ID: <B256D81BAE5131468A838E5D7A24364154234E9D@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It is OK for spi

Thanks

Best Regards,
Wenyou Yang

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr at canb.auug.org.au]
> Sent: 2013?4?26? 15:07
> To: Olof Johansson; Arnd Bergmann; linux-arm-kernel at lists.infradead.org
> Cc: linux-next at vger.kernel.org; linux-kernel at vger.kernel.org; Yang, Wenyou;
> Richard Genoud; Mark Brown; Ferre, Nicolas
> Subject: linux-next: manual merge of the arm-soc tree with the spi-mb tree
> 
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/boot/dts/at91sam9x5.dtsi between commits d50f88a0c304 ("ARM:
> dts: add spi nodes for atmel SoC") and a68b728f7a21 ("ARM: dts: add pinctrl
> property for spi node for atmel SoC") from the spi-mb tree and commits
> e9a72ee81d58 ("ARM: at91: dt: at91sam9x5: add i2c pinctrl"),
> 463c9c7bf1f3 ("ARM: at91: dt: at91sam9x5: add i2c-gpio pinctrl") and
> b909c6c94462 ("ARM: at91/at91sam9x5: add RTC node") from the arm-soc
> tree.
> 
> I fixed it up (hopefully - see below) and can carry the fix as necessary (no action
> is required).
> 
> --
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/boot/dts/at91sam9x5.dtsi index 347b438,284bf24..0000000
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@@ -343,23 -343,53 +343,70 @@@
>   					};
>   				};
> 
>  +				spi0 {
>  +					pinctrl_spi0: spi0-0 {
>  +						atmel,pins =
>  +							<0 11 0x1 0x0	/* PA11 periph A SPI0_MISO
> pin */
>  +							 0 12 0x1 0x0	/* PA12 periph A SPI0_MOSI
> pin */
>  +							 0 13 0x1 0x0>;	/* PA13 periph A
> SPI0_SPCK pin */
>  +					};
>  +				};
>  +
>  +				spi1 {
>  +					pinctrl_spi1: spi1-0 {
>  +						atmel,pins =
>  +							<0 21 0x2 0x0	/* PA21 periph B SPI1_MISO
> pin */
>  +							 0 22 0x2 0x0	/* PA22 periph B SPI1_MOSI
> pin */
>  +							 0 23 0x2 0x0>;	/* PA23 periph B
> SPI1_SPCK pin */
>  +					};
>  +				};
> + 				i2c0 {
> + 					pinctrl_i2c0: i2c0-0 {
> + 						atmel,pins =
> + 							<0 30 0x1 0x0	/* PA30 periph A I2C0 data */
> + 							 0 31 0x1 0x0>;	/* PA31 periph A I2C0
> clock */
> + 					};
> + 				};
> +
> + 				i2c1 {
> + 					pinctrl_i2c1: i2c1-0 {
> + 						atmel,pins =
> + 							<2 0 0x3 0x0	/* PC0 periph C I2C1 data */
> + 							 2 1 0x3 0x0>;	/* PC1 periph C I2C1 clock */
> + 					};
> + 				};
> +
> + 				i2c2 {
> + 					pinctrl_i2c2: i2c2-0 {
> + 						atmel,pins =
> + 							<1 4 0x2 0x0	/* PB4 periph B I2C2 data */
> + 							 1 5 0x2 0x0>;	/* PB5 periph B I2C2 clock */
> + 					};
> + 				};
> +
> + 				i2c_gpio0 {
> + 					pinctrl_i2c_gpio0: i2c_gpio0-0 {
> + 						atmel,pins =
> + 							<0 30 0x0 0x2	/* PA30 gpio multidrive I2C0
> data */
> + 							 0 31 0x0 0x2>;	/* PA31 gpio multidrive
> I2C0 clock */
> + 					};
> + 				};
> +
> + 				i2c_gpio1 {
> + 					pinctrl_i2c_gpio1: i2c_gpio1-0 {
> + 						atmel,pins =
> + 							<2 0 0x0 0x2	/* PC0 gpio multidrive I2C1
> data */
> + 							 2 1 0x0 0x2>;	/* PC1 gpio multidrive I2C1
> clock */
> + 					};
> + 				};
> +
> + 				i2c_gpio2 {
> + 					pinctrl_i2c_gpio2: i2c_gpio2-0 {
> + 						atmel,pins =
> + 							<1 4 0x0 0x2	/* PB4 gpio multidrive I2C2
> data */
> + 							 1 5 0x0 0x2>;	/* PB5 gpio multidrive I2C2
> clock */
> + 					};
> + 				};
> 
>   				pioA: gpio at fffff400 {
>   					compatible = "atmel,at91sam9x5-gpio",
> "atmel,at91rm9200-gpio"; @@@ -548,27 -587,12 +604,33 @@@
>   				};
>   			};
> 
>  +			spi0: spi at f0000000 {
>  +				#address-cells = <1>;
>  +				#size-cells = <0>;
>  +				compatible = "atmel,at91rm9200-spi";
>  +				reg = <0xf0000000 0x100>;
>  +				interrupts = <13 4 3>;
>  +				pinctrl-names = "default";
>  +				pinctrl-0 = <&pinctrl_spi0>;
>  +				status = "disabled";
>  +			};
>  +
>  +			spi1: spi at f0004000 {
>  +				#address-cells = <1>;
>  +				#size-cells = <0>;
>  +				compatible = "atmel,at91rm9200-spi";
>  +				reg = <0xf0004000 0x100>;
>  +				interrupts = <14 4 3>;
>  +				pinctrl-names = "default";
>  +				pinctrl-0 = <&pinctrl_spi1>;
>  +				status = "disabled";
>  +			};
> + 			rtc at fffffeb0 {
> + 				compatible = "atmel,at91rm9200-rtc";
> + 				reg = <0xfffffeb0 0x40>;
> + 				interrupts = <1 4 7>;
> + 				status = "disabled";
> + 			};
>   		};
> 
>   		nand0: nand at 40000000 {
