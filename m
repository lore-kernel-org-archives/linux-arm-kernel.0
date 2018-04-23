From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 23 Apr 2018 14:58:48 +0800
Subject: [PATCH] arm64: allwinner: h6: restore the usage of CCU slice
 macros
In-Reply-To: <20180403134024.43156-1-icenowy@aosc.io>
References: <20180403134024.43156-1-icenowy@aosc.io>
Message-ID: <1524466728.25095.0.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-04-03?? 21:40 +0800?Icenowy Zheng???
> As the definition of CCU slice macros are already merged into the
> source
> tree, restore the usage of the macros now.

Maxime, could you check this patch and pick it?

Thanks!

> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 20 +++++++++++-------
> --
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 56563150d61a..4debc3962830 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-h6-ccu.h>
> +#include <dt-bindings/reset/sun50i-h6-ccu.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -115,7 +117,7 @@
>  				     <GIC_SPI 53
> IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 54
> IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 59
> IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ccu 26>, <&osc24M>, <&osc32k>;
> +			clocks = <&ccu CLK_APB1>, <&osc24M>,
> <&osc32k>;
>  			clock-names = "apb", "hosc", "losc";
>  			gpio-controller;
>  			#gpio-cells = <3>;
> @@ -134,8 +136,8 @@
>  			interrupts = <GIC_SPI 0
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 70>;
> -			resets = <&ccu 21>;
> +			clocks = <&ccu CLK_BUS_UART0>;
> +			resets = <&ccu RST_BUS_UART0>;
>  			status = "disabled";
>  		};
>  
> @@ -145,8 +147,8 @@
>  			interrupts = <GIC_SPI 1
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 71>;
> -			resets = <&ccu 22>;
> +			clocks = <&ccu CLK_BUS_UART1>;
> +			resets = <&ccu RST_BUS_UART1>;
>  			status = "disabled";
>  		};
>  
> @@ -156,8 +158,8 @@
>  			interrupts = <GIC_SPI 2
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 72>;
> -			resets = <&ccu 23>;
> +			clocks = <&ccu CLK_BUS_UART2>;
> +			resets = <&ccu RST_BUS_UART2>;
>  			status = "disabled";
>  		};
>  
> @@ -167,8 +169,8 @@
>  			interrupts = <GIC_SPI 3
> IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&ccu 73>;
> -			resets = <&ccu 24>;
> +			clocks = <&ccu CLK_BUS_UART3>;
> +			resets = <&ccu RST_BUS_UART3>;
>  			status = "disabled";
>  		};
>  	};
