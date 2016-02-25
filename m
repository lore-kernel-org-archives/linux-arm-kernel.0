From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 11:38:09 -0800
Subject: [PATCH v5 4/4] ARM: dts: sun8i: Add leds and switch on Orangepi
 Plus boards
In-Reply-To: <1456146208-13890-5-git-send-email-k@japko.eu>
References: <1456146208-13890-1-git-send-email-k@japko.eu>
 <1456146208-13890-5-git-send-email-k@japko.eu>
Message-ID: <20160225193809.GO4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 22, 2016 at 02:03:28PM +0100, Krzysztof Adamski wrote:
> OrangePi Plus board has two leds - green ("pwr") and red ("status")
> and a switch ("sw4"). This patch describes them in a devicetree.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 63 ++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index e67df59..5f159d0 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -45,6 +45,7 @@
>  #include "sunxi-common-regulators.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
>  
>  / {
> @@ -58,6 +59,68 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_opc>;
> +
> +		status_led {
> +			label = "status:red:user";
> +			gpios = <&pio 0 15 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	r_leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_r_opc>;
> +
> +		tx {
> +			label = "pwr:green:user";
> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +	};

You can merge the two gpio-leds nodes into a single one.

Plus, the label format is <board>:<colour>:<role>

In these case, it would be more "orangepi-plus:red:status" and
"orangepi-plus:green:pwr".

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/a0c53bfe/attachment.sig>
