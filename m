From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 10 Apr 2017 11:04:56 +0200
Subject: [PATCH 2/2] ARM: dts: at91: sama5d3_xplained: not all ADC
 channels are available
In-Reply-To: <20170410082517.19628-2-ludovic.desroches@microchip.com>
References: <20170410082517.19628-1-ludovic.desroches@microchip.com>
 <20170410082517.19628-2-ludovic.desroches@microchip.com>
Message-ID: <32a56914-7e10-d5ab-1eb0-436941ce368c@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/04/2017 ? 10:25, Ludovic Desroches a ?crit :
> Remove ADC channels that are not available by default on the sama5d3_xplained
> board (resistor not populated) in order to not create confusion.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: <stable@vger.kernel.org> # 3.16+

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index 7a0fa1a..5a53fcf 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -163,9 +163,9 @@
>  
>  			adc0: adc at f8018000 {
>  				atmel,adc-vref = <3300>;
> +				atmel,adc-channels-used = <0xfe>;
>  				pinctrl-0 = <
>  					&pinctrl_adc0_adtrg
> -					&pinctrl_adc0_ad0
>  					&pinctrl_adc0_ad1
>  					&pinctrl_adc0_ad2
>  					&pinctrl_adc0_ad3
> @@ -173,8 +173,6 @@
>  					&pinctrl_adc0_ad5
>  					&pinctrl_adc0_ad6
>  					&pinctrl_adc0_ad7
> -					&pinctrl_adc0_ad8
> -					&pinctrl_adc0_ad9
>  					>;
>  				status = "okay";
>  			};
> 


-- 
Nicolas Ferre
