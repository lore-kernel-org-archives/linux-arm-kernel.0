From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Oct 2015 14:18:27 +0200
Subject: [PATCH] ARM: at91/dt: sama5d4: add the macb1 node
In-Reply-To: <1444997510-8841-1-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 16 Oct 2015 14:11:50 +0200")
References: <1444997510-8841-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87si5bgg6k.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

please ignore this patch, some garbage slipt in it.
I will send a proper one in a few minute

Sorry for the noise

Gregory
 
 On ven., oct. 16 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> The second macb is present on all sama5d4 soc. Let's add a node
> reflecting it in the device tree.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91-vinco.dts |  5 +----
>  arch/arm/boot/dts/sama5d4.dtsi   | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
> index b8036f5..2215e2e 100644
> --- a/arch/arm/boot/dts/at91-vinco.dts
> +++ b/arch/arm/boot/dts/at91-vinco.dts
> @@ -82,10 +82,7 @@
>  		apb {
>  
>  			adc0: adc at fc034000 {
> -				/* The vref depends on JP22 of EK. If connect 1-2 then use 3.3V. connect 2-3 use 3.0V */
> -				atmel,adc-vref = <3300>;
> -				/*atmel,adc-ts-wires = <4>;*/	/* Set up ADC touch screen */
> -				status = "okay";		/* Enable ADC IIO support */
> +				status = "okay"; /* Enable ADC IIO support */
>  			};
>  
>  			mmc0: mmc at f8000000 {
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index b5ee947..6f27915 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1188,6 +1188,19 @@
>  				clock-names = "t0_clk", "slow_clk";
>  			};
>  
> +			macb1: ethernet at fc028000 {
> +				compatible = "atmel,sama5d4-gem";
> +				reg = <0xfc028000 0x100>;
> +				interrupts = <55 IRQ_TYPE_LEVEL_HIGH 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_macb1_rmii>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&macb1_clk>, <&macb1_clk>;
> +				clock-names = "hclk", "pclk";
> +				status = "disabled";
> +			};
> +
>  			adc0: adc at fc034000 {
>  				compatible = "atmel,at91sam9x5-adc";
>  				reg = <0xfc034000 0x100>;
> @@ -1635,6 +1648,23 @@
>  					};
>  				};
>  
> +				macb1 {
> +					pinctrl_macb1_rmii: macb1_rmii-0 {
> +						atmel,pins =
> +							<AT91_PIOA 14 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_TX0 */
> +							 AT91_PIOA 15 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_TX1 */
> +							 AT91_PIOA 12 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_RX0 */
> +							 AT91_PIOA 13 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_RX1 */
> +							 AT91_PIOA 10 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_RXDV */
> +							 AT91_PIOA 11 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_RXER */
> +							 AT91_PIOA  4 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_TXEN */
> +							 AT91_PIOA  2 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_TXCK */
> +							 AT91_PIOA 22 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_MDC */
> +							 AT91_PIOA 23 AT91_PERIPH_B AT91_PINCTRL_NONE	/* G1_MDIO */
> +							>;
> +					};
> +				};
> +
>  				mmc0 {
>  					pinctrl_mmc0_clk_cmd_dat0: mmc0_clk_cmd_dat0 {
>  						atmel,pins =
> -- 
> 2.1.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
