From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Thu, 24 Apr 2014 00:51:25 +0200
Subject: [PATCH 4/5] ARM: berlin/dt: add sdio clocks to BG2CD
In-Reply-To: <1398261667-12621-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398261667-12621-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1398261667-12621-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140423225125.GB12738@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

On Wed, Apr 23, 2014 at 04:01:06PM +0200, Alexandre Belloni wrote:
> Add sdio clocks to the berlin2cd.dtsi
> Also reorder the PLLs nodes by address
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/berlin2cd.dtsi | 42 ++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
> index bd4e9dd4867e..9b3faeee0728 100644
> --- a/arch/arm/boot/dts/berlin2cd.dtsi
> +++ b/arch/arm/boot/dts/berlin2cd.dtsi
> @@ -79,20 +79,6 @@
>  			clocks = <&twdclk>;
>  		};
>  
> -		syspll: syspll at ea0014 {
> -			compatible = "marvell,berlin2-pll";
> -			clocks = <&smclk>;
> -			#clock-cells = <0>;
> -			reg = <0xf7ea0014 8>;
> -		};
> -
> -		cpupll: cpupll at ea003c {
> -			compatible = "marvell,berlin2-pll";
> -			clocks = <&smclk>;
> -			#clock-cells = <0>;
> -			reg = <0xf7ea003c 8>;
> -		};
> -
>  		apb at e80000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> @@ -183,6 +169,34 @@
>  			};
>  		};
>  
> +		syspll: syspll at ea0014 {
> +			compatible = "marvell,berlin2-pll";
> +			clocks = <&smclk>;
> +			#clock-cells = <0>;
> +			reg = <0xf7ea0014 8>;

You can drop the 'f7' here

> +		};
> +
> +		cpupll: cpupll at ea003c {
> +			compatible = "marvell,berlin2-pll";
> +			clocks = <&smclk>;
> +			#clock-cells = <0>;
> +			reg = <0xf7ea003c 8>;

and here.

Thanks!

Antoine

> +		};
> +
> +		sdio0xinclk: sdio0xinclk at ea023c {
> +			compatible = "marvell,berlin-clk";
> +			clocks = <&syspll>;
> +			#clock-cells = <0>;
> +			reg = <0xea023c 4>;
> +		};
> +
> +		sdio1xinclk: sdio1xinclk at ea0240 {
> +			compatible = "marvell,berlin-clk";
> +			clocks = <&syspll>;
> +			#clock-cells = <0>;
> +			reg = <0xea0240 4>;
> +		};
> +
>  		apb at fc0000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
