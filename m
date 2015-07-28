From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jul 2015 09:32:20 +0200
Subject: [PATCH 2/2] ARM: at91/dt: sama5d4: move ADC pinctrl to board
 device trees
In-Reply-To: <1434959149-4067-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1434959149-4067-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1434959149-4067-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55B73004.2070401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/06/2015 09:45, Alexandre Belloni a ?crit :
> The ADC pinctrl is board specific, move it to the board device trees.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

To the series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts | 9 +++++++++
>  arch/arm/boot/dts/at91-sama5d4ek.dts        | 9 +++++++++
>  arch/arm/boot/dts/sama5d4.dtsi              | 9 ---------
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index c740e1a2a3a5..50033760df93 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -123,6 +123,15 @@
>  			};
>  
>  			adc0: adc at fc034000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <
> +					/* external trigger conflicts with USBA_VBUS */
> +					&pinctrl_adc0_ad0
> +					&pinctrl_adc0_ad1
> +					&pinctrl_adc0_ad2
> +					&pinctrl_adc0_ad3
> +					&pinctrl_adc0_ad4
> +					>;
>  				atmel,adc-vref = <3300>;
>  				status = "okay";
>  			};
> diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
> index 89ef4a540db5..202891b4c1b7 100644
> --- a/arch/arm/boot/dts/at91-sama5d4ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
> @@ -99,6 +99,15 @@
>  			};
>  
>  			adc0: adc at fc034000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <
> +					/* external trigger conflicts with USBA_VBUS */
> +					&pinctrl_adc0_ad0
> +					&pinctrl_adc0_ad1
> +					&pinctrl_adc0_ad2
> +					&pinctrl_adc0_ad3
> +					&pinctrl_adc0_ad4
> +					>;
>  				/* The vref depends on JP22 of EK. If connect 1-2 then use 3.3V. connect 2-3 use 3.0V */
>  				atmel,adc-vref = <3300>;
>  				/*atmel,adc-ts-wires = <4>;*/	/* Set up ADC touch screen */
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index ca1e52989a29..04779fe1c70b 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1078,15 +1078,6 @@
>  				compatible = "atmel,at91sam9x5-adc";
>  				reg = <0xfc034000 0x100>;
>  				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 5>;
> -				pinctrl-names = "default";
> -				pinctrl-0 = <
> -					/* external trigger is conflict with USBA_VBUS */
> -					&pinctrl_adc0_ad0
> -					&pinctrl_adc0_ad1
> -					&pinctrl_adc0_ad2
> -					&pinctrl_adc0_ad3
> -					&pinctrl_adc0_ad4
> -					>;
>  				clocks = <&adc_clk>,
>  					 <&adc_op_clk>;
>  				clock-names = "adc_clk", "adc_op_clk";
> 


-- 
Nicolas Ferre
