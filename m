From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 5 Sep 2014 17:26:35 +0200
Subject: [PATCH] ARM: at91/dt: rm9200: fix usb clock definition
In-Reply-To: <1409928312-24235-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1409928312-24235-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5409D62B.2070902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2014 16:45, Alexandre Belloni :
> The atmel,clk-divisors property is taking 4 divisors, if less are
> provided, the clock registration will fail.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Stacked on at91-3.17-fixes.

> ---
>  arch/arm/boot/dts/at91rm9200.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
> index 65ccf564b9a5..6c97d4af61ee 100644
> --- a/arch/arm/boot/dts/at91rm9200.dtsi
> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
> @@ -149,7 +149,7 @@
>  				usb: usbck {
>  					compatible = "atmel,at91rm9200-clk-usb";
>  					#clock-cells = <0>;
> -					atmel,clk-divisors = <1 2>;
> +					atmel,clk-divisors = <1 2 0 0>;
>  					clocks = <&pllb>;
>  				};
>  
> 


-- 
Nicolas Ferre
