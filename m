From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 24 Apr 2017 11:04:43 +0200
Subject: [PATCH 1/3] ARM: dts: at91: sama5d2_xplained: enable ADTRG pin
In-Reply-To: <1492590045-17329-2-git-send-email-eugen.hristev@microchip.com>
References: <1492590045-17329-1-git-send-email-eugen.hristev@microchip.com>
 <1492590045-17329-2-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20170424090443.g4ywq5soomzbjmk3@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 11:20:43AM +0300, Eugen Hristev wrote:
> Enable pinctrl for ADTRG pin (PD31) for ADC hardware trigger support.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 0bef9e0..04754b1 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -303,7 +303,7 @@
>  				vddana-supply = <&vdd_3v3_lp_reg>;
>  				vref-supply = <&vdd_3v3_lp_reg>;
>  				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_adc_default>;
> +				pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
>  				status = "okay";
>  			};
>  
> @@ -322,6 +322,20 @@
>  					bias-disable;
>  				};
>  
> +				/*
> +				 * The ADTRG pin can work on any edge type.
> +				 * In here it's being pulled up, so need to
> +				 * connect it to ground to get an edge e.g.
> +				 * Trigger can be configured on falling, rise
> +				 * or any edge, and the pull-up can be changed
> +				 * to pull-down or left floating according to
> +				 * needs.
> +				 */
> +				pinctrl_adtrg_default: adtrg_default {
> +					pinmux = <PIN_PD31__ADTRG>;
> +					bias-pull-up;
> +				};
> +
>  				pinctrl_charger_chglev: charger_chglev {
>  					pinmux = <PIN_PA12__GPIO>;
>  					bias-disable;
> -- 
> 2.7.4
> 
