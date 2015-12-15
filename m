From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 15 Dec 2015 11:14:18 +0100
Subject: [PATCH] ARM: at91/dt: sama5d2: add watchdog node
In-Reply-To: <1446709170-24500-1-git-send-email-wenyou.yang@atmel.com>
References: <1446709170-24500-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <566FE7FA.6040300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/11/2015 08:39, Wenyou Yang a ?crit :
> Add watchdog node to support SAMA5D4 watchdog.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on top of at91-4.5-dt.

Thanks!

> ---
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts |    4 ++++
>  arch/arm/boot/dts/sama5d2.dtsi              |    7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index e07c2b2..de3ef02 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -181,6 +181,10 @@
>  				};
>  			};
>  
> +			watchdog at f8048040 {
> +				status = "okay";
> +			};
> +
>  			uart3: serial at fc008000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_uart3_default>;
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index c1f0cba..c29ff70 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -929,6 +929,13 @@
>  				clocks = <&h32ck>;
>  			};
>  
> +			watchdog at f8048040 {
> +				compatible = "atmel,sama5d4-wdt";
> +				reg = <0xf8048040 0x10>;
> +				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
> +				status = "disabled";
> +			};
> +
>  			sckc at f8048050 {
>  				compatible = "atmel,at91sam9x5-sckc";
>  				reg = <0xf8048050 0x4>;
> 


-- 
Nicolas Ferre
