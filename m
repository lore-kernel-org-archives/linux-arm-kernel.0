From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Mar 2014 15:20:26 +0100
Subject: [PATCH] ARM: at91: sama5d3: get rid of atmel_tsadcc driver
In-Reply-To: <1393432190-8799-1-git-send-email-ludovic.desroches@atmel.com>
References: <1393432190-8799-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <53206D2A.1090403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/02/2014 17:29, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Touchscreen support for at91_adc has been introduced so we can get rid of
> atmel_tsadcc.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

stacked on at91-3.15-dt.

Thanks,

> ---
>  arch/arm/boot/dts/sama5d3.dtsi    |   14 +-------------
>  arch/arm/boot/dts/sama5d3xdm.dtsi |    7 +++----
>  2 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 3d5faf8..26d7ed5 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -239,7 +239,7 @@
>  			};
>  
>  			adc0: adc at f8018000 {
> -				compatible = "atmel,at91sam9260-adc";
> +				compatible = "atmel,at91sam9x5-adc";
>  				reg = <0xf8018000 0x100>;
>  				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
>  				pinctrl-names = "default";
> @@ -295,18 +295,6 @@
>  				};
>  			};
>  
> -			tsadcc: tsadcc at f8018000 {
> -				compatible = "atmel,at91sam9x5-tsadcc";
> -				reg = <0xf8018000 0x4000>;
> -				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
> -				atmel,tsadcc_clock = <300000>;
> -				atmel,filtering_average = <0x03>;
> -				atmel,pendet_debounce = <0x08>;
> -				atmel,pendet_sensitivity = <0x02>;
> -				atmel,ts_sample_hold_time = <0x0a>;
> -				status = "disabled";
> -			};
> -
>  			i2c2: i2c at f801c000 {
>  				compatible = "atmel,at91sam9x5-i2c";
>  				reg = <0xf801c000 0x4000>;
> diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
> index f9bdde5..0b8f5d1 100644
> --- a/arch/arm/boot/dts/sama5d3xdm.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xdm.dtsi
> @@ -23,10 +23,9 @@
>  			};
>  
>  			adc0: adc at f8018000 {
> -				status = "disabled";
> -			};
> -
> -			tsadcc: tsadcc at f8018000 {
> +				atmel,adc-clock-rate = <1000000>;
> +				atmel,adc-ts-wires = <4>;
> +				atmel,adc-ts-pressure-threshold = <10000>;
>  				status = "okay";
>  			};
>  
> 


-- 
Nicolas Ferre
