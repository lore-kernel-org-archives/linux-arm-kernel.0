From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 03 Feb 2016 10:24:19 +0100
Subject: [PATCH v2] ARM: dts: Add dts for Uniwest evi
In-Reply-To: <1454451202-1687-1-git-send-email-stillcompiling@gmail.com>
References: <patches/evidts/35215>
 <1454451202-1687-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1454491459.3415.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

Am Dienstag, den 02.02.2016, 14:13 -0800 schrieb Joshua Clayton:
> Uniwest evi is a portable electrical eddy current non-destructive
> testing device.
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile      |   1 +
>  arch/arm/boot/dts/imx6q-evi.dts | 506 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 507 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-evi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c4f42a78..4a4ef29 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -326,6 +326,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-cubox-i.dtb \
>  	imx6q-dfi-fs700-m60.dtb \
>  	imx6q-dmo-edmqmx6.dtb \
> +	imx6q-evi.dtb \
>  	imx6q-gk802.dtb \
>  	imx6q-gw51xx.dtb \
>  	imx6q-gw52xx.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
> new file mode 100644
> index 0000000..10f566e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-evi.dts
> @@ -0,0 +1,506 @@
[...]
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "Uniwest Evi";
> +	compatible = "uniwest,imx6q-evi", "fsl,imx6q";
[...]
> +	panel {
> +		compatible = "sharp,lq101k1ly04";
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> +};
[...]
> +&ldb {
> +	status = "okay";
> +
> +	lvds0: lvds-channel at 0 {
> +		fsl,data-mapping = "jeida";
> +		fsl,data-width = <24>;

The "sharp,lq101k1ly04" panel compatible already specifies the bus
format (it is set to MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA in the
simple-panel entry), these two properties can be removed.

> +		status = "okay";
> +
> +		port at 4 {
> +			reg = <4>;
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
[...]

regards
Philipp
