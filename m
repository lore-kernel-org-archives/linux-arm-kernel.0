From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 12:16:45 +0100
Subject: [PATCH 02/04] ARM: shmobile: Genmai LED1 and LED2 support
In-Reply-To: <20131127082755.20015.95975.sendpatchset@w520>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127082755.20015.95975.sendpatchset@w520>
Message-ID: <1698428.WpE2zkcoKU@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Wednesday 27 November 2013 17:27:55 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add support for Genmai board LED1 and LED2 via gpio-leds.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> --- 0001/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-11-27
> 15:49:27.000000000 +0900 @@ -9,7 +9,8 @@
>   */
> 
>  /dts-v1/;
> -/include/ "r7s72100.dtsi"
> +#include "r7s72100.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> 
>  / {
>  	model = "Genmai";
> @@ -28,4 +29,14 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led1 {
> +			gpios = <&port4 10 GPIO_ACTIVE_LOW>;
> +		};
> +		led2 {
> +			gpios = <&port4 11 GPIO_ACTIVE_LOW>;
> +		};
> +	};
>  };
-- 
Regards,

Laurent Pinchart
