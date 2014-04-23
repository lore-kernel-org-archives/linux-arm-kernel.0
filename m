From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 23 Apr 2014 11:45:45 +0200
Subject: [PATCH 3/3] ARM: at91/dt: sam9rl: Fix PLL output range and mck
 divisors
In-Reply-To: <1398243220-20874-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398243220-20874-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1398243220-20874-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53578BC9.3070908@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23/04/2014 10:53, Alexandre Belloni wrote:
> Argument 3 (OUT) and 4 (ICPLL) of the atmel,pll-clk-output-ranges were missing.
> Also, the at91sam9rl doesn't really have a by 3 divisor.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91sam9rl.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
> index a19a7c26a7fc..1109e7fbf9bd 100644
> --- a/arch/arm/boot/dts/at91sam9rl.dtsi
> +++ b/arch/arm/boot/dts/at91sam9rl.dtsi
> @@ -574,8 +574,9 @@
>  					clocks = <&main>;
>  					reg = <0>;
>  					atmel,clk-input-range = <1000000 32000000>;
> -					#atmel,pll-clk-output-range-cells = <4>;
> -					atmel,pll-clk-output-ranges = <80000000 200000000 190000000 240000000>;
> +					#atmel,pll-clk-output-range-cells = <3>;
> +					atmel,pll-clk-output-ranges = <80000000 200000000 0>,
> +								<190000000 240000000 2>;
>  				};
>  
>  				utmi: utmick {
> @@ -592,7 +593,7 @@
>  					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
>  					clocks = <&clk32k>, <&main>, <&plla>, <&utmi>;
>  					atmel,clk-output-range = <0 94000000>;
> -					atmel,clk-divisors = <1 2 4 3>;
> +					atmel,clk-divisors = <1 2 4 0>;
>  				};
>  
>  				prog: progck {

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
