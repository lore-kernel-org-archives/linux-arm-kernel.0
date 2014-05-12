From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 May 2014 15:04:36 +0200
Subject: [PATCH 1/3] ARM: at91/dt: sam9261: Fix PLL output ranges and
 other clocks divisors
In-Reply-To: <1398243220-20874-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398243220-20874-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5370C6E4.3020509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

To the whole series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and pushed on at91-3.16-dt2

Thanks, bye,

On 23/04/2014 10:53, Alexandre Belloni :
> Argument 3 (OUT) and 4 (ICPLL) of the atmel,pll-clk-output-ranges were missing.
> Also, the at91sam9261 doesn't really have a by 3 divisor.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91sam9261.dtsi | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
> index 561addceb81e..3ff239b26d72 100644
> --- a/arch/arm/boot/dts/at91sam9261.dtsi
> +++ b/arch/arm/boot/dts/at91sam9261.dtsi
> @@ -564,7 +564,8 @@
>  					reg = <0>;
>  					atmel,clk-input-range = <1000000 32000000>;
>  					#atmel,pll-clk-output-range-cells = <4>;
> -					atmel,pll-clk-output-ranges = <80000000 200000000 190000000 240000000>;
> +					atmel,pll-clk-output-ranges = <80000000 200000000 0 1>,
> +								<190000000 240000000 2 1>;
>  				};
>  
>  				pllb: pllbck {
> @@ -575,7 +576,8 @@
>  					reg = <1>;
>  					atmel,clk-input-range = <1000000 32000000>;
>  					#atmel,pll-clk-output-range-cells = <4>;
> -					atmel,pll-clk-output-ranges = <80000000 200000000 190000000 240000000>;
> +					atmel,pll-clk-output-ranges = <80000000 200000000 0 1>,
> +								<190000000 240000000 2 1>;
>  				};
>  
>  				mck: masterck {
> @@ -584,13 +586,13 @@
>  					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
>  					clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
>  					atmel,clk-output-range = <0 94000000>;
> -					atmel,clk-divisors = <1 2 4 3>;
> +					atmel,clk-divisors = <1 2 4 0>;
>  				};
>  
>  				usb: usbck {
>  					compatible = "atmel,at91rm9200-clk-usb";
>  					#clock-cells = <0>;
> -					atmel,clk-divisors = <1 2 4 3>;
> +					atmel,clk-divisors = <1 2 4 0>;
>  					clocks = <&pllb>;
>  				};
>  
> 


-- 
Nicolas Ferre
