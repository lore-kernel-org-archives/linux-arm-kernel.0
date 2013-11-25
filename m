From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Nov 2013 11:31:16 +0900
Subject: [PATCH] ARM: shmobile: Koelsch DT reference GPIO LED support
In-Reply-To: <20131121004404.16471.71617.sendpatchset@w520>
References: <20131121004404.16471.71617.sendpatchset@w520>
Message-ID: <20131125023114.GE10664@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 09:44:04AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add led6, led7 and led8 to the Koelsch DT reference board support.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.

> ---
> 
>  arch/arm/boot/dts/r8a7791-koelsch-reference.dts |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> --- 0024/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> +++ work/arch/arm/boot/dts/r8a7791-koelsch-reference.dts	2013-11-20 17:15:02.000000000 +0900
> @@ -11,6 +11,7 @@
>  
>  /dts-v1/;
>  #include "r8a7791.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "Koelsch";
> @@ -29,6 +30,19 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led6 {
> +			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		};
> +		led7 {
> +			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
> +		};
> +		led8 {
> +			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
>  };
>  
>  &pfc {
> 
