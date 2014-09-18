From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Sep 2014 18:17:53 +0200
Subject: [PATCH] ARM: at91/dt: at91sam9m10g45ek add rtc node
In-Reply-To: <1409655132-17735-1-git-send-email-evanluijk@interact.nl>
References: <1409655132-17735-1-git-send-email-evanluijk@interact.nl>
Message-ID: <541B05B1.6020302@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2014 12:52, Erik van Luijk :
> Signed-off-by: Erik van Luijk <evanluijk@interact.nl>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and added to the at91-3.18-dt3 branch.

I also sent your remarks to the Documentation department in Atmel:
thanks a lot for your help.

> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi     | 7 +++++++
>  arch/arm/boot/dts/at91sam9m10g45ek.dts | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 932a669..bf62c18 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -1070,6 +1070,13 @@
>  				status = "disabled";
>  			};
>  
> +			rtc at fffffdb0 {
> +				compatible = "atmel,at91rm9200-rtc";
> +				reg = <0xfffffdb0 0x30>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				status = "disabled";
> +			};
> +
>  			spi0: spi at fffa4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index 96ccc7d..2dd2347 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -70,6 +70,9 @@
>  
>  			watchdog at fffffd40 {
>  				status = "okay";

BTW, there was an issue here: "};" missing..

I corrected it.

> +
> +			rtc at fffffdb0 {
> +				status = "okay";
>  			};
>  
>  			mmc0: mmc at fff80000 {
> 


-- 
Nicolas Ferre
