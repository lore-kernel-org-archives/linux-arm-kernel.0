From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Mar 2015 21:32:54 +0800
Subject: [PATCH v2] dts: cubox: Map gpio-keys to gpio3 8
In-Reply-To: <1426542829-16786-1-git-send-email-george.joseph@fairview5.com>
References: <1426542829-16786-1-git-send-email-george.joseph@fairview5.com>
Message-ID: <20150323133252.GE28410@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 03:53:49PM -0600, George Joseph wrote:
> The Cubox has a recessed button between the HDMI and RJ-45 connectors
> that wasn't mapped in the device tree, so I've mapped it to gpio-keys
> BTN_0.
> 
> Signed-off-by: George Joseph <george.joseph@fairview5.com>
> Tested-by: George Joseph <george.joseph@fairview5.com>

Russell,

Are you fine with this patch?

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> index 6a524ca..de6e3a8 100644
> --- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> @@ -3,6 +3,8 @@
>   */
>  #include "imx6qdl-microsom.dtsi"
>  #include "imx6qdl-microsom-ar8035.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	ir_recv: ir-receiver {
> @@ -66,6 +68,18 @@
>  		spdif-controller = <&spdif>;
>  		spdif-out;
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pinctrl_gpio_key>;
> +		pinctrl-names = "default";
> +
> +		button_0 {
> +			label = "Button 0";
> +			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <BTN_0>;
> +		};
> +	};
>  };
>  
>  &hdmi {
> @@ -170,6 +184,12 @@
>  				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
>  			>;
>  		};
> +
> +		pinctrl_gpio_key: gpio-key {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_DA8__GPIO3_IO08	0x17059
> +			>;
> +		};
>  	};
>  };
>  
> -- 
> 2.1.0
> 
