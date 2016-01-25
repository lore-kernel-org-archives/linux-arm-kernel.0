From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 Jan 2016 12:34:24 +0100
Subject: [PATCH 3/3] ARM: dts: sama5d4: add support for Ka-Ro electronics
 TXA5 modules
In-Reply-To: <1453293337-16078-4-git-send-email-LW@KARO-electronics.de>
References: <1453293337-16078-1-git-send-email-LW@KARO-electronics.de>
 <1453293337-16078-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160125113424.GD4027@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/01/2016 at 13:35:37 +0100, Lothar Wa?mann wrote :
> diff --git a/arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts b/arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts
> new file mode 100644
> index 0000000..fb4a253
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts
> @@ -0,0 +1,217 @@
> +/*
> + * at91-sama5d4-txa5.dts - Device Tree file for Ka-Ro electronics TXA5 module
> + *

This file can also be called at91-txa5-5010.dts if you prefer unless you
plan to have multiple variants of the board with different SoCs.

> +/dts-v1/;
> +#include "sama5d4.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "Ka-Ro SAMA5D4 TXA5";
> +	compatible = "atmel,sama5d4-txa5", "atmel,sama5d4", "atmel,sama5";
> +

The vendor for sama5d4-txa5 is not atmel, this should be
"karo,sama5d4-txa5".

Don't forget to add that vendor prefix in
Documentation/devicetree/bindings/vendor-prefixes.txt


> +	aliases {
> +		display = &display;
> +		ethernet0 = &macb0;
> +		serial0 = &usart0;
> +		serial1 = &usart1;
> +		serial2 = &usart3;
> +		spi0 = &spi0;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +

Those properties should be removed. You probably based yourself on a dts
for an old kernel.

> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <12000000>;
> +		};

This node is useless, I think you can remove the whole clocks groups as
you define slow_xtal and main_xtal later.

> +	display: display {
> +		display-timings {
> +		};
> +	};
> +

Don't you need some timings?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
