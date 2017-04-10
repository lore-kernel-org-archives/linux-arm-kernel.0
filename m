From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 10 Apr 2017 11:04:44 +0200
Subject: [PATCH 1/2] ARM: dts: at91: sama5d3_xplained: fix ADC vref
In-Reply-To: <20170410082517.19628-1-ludovic.desroches@microchip.com>
References: <20170410082517.19628-1-ludovic.desroches@microchip.com>
Message-ID: <0c78ac8e-1e1f-14c3-e510-1caf857d4ef5@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/04/2017 ? 10:25, Ludovic Desroches a ?crit :
> The voltage reference for the ADC is not 3V but 3.3V since it is connected to
> VDDANA.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: <stable@vger.kernel.org> # 3.16+

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index c51fc65..7a0fa1a 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -162,6 +162,7 @@
>  			};
>  
>  			adc0: adc at f8018000 {
> +				atmel,adc-vref = <3300>;
>  				pinctrl-0 = <
>  					&pinctrl_adc0_adtrg
>  					&pinctrl_adc0_ad0
> 


-- 
Nicolas Ferre
