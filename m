From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Jul 2015 12:25:47 +0100
Subject: [PATCH 2/5] Documentation: Detail permitted DT properties for
 the imx6ul_tsc
In-Reply-To: <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
Message-ID: <20150727112547.GE9169@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 12:26:44PM +0100, Haibo Chen wrote:
> Here we apply required documentation for the imx6ul touch screen
> controller driver which describe available properties and how to
> use them.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> new file mode 100644
> index 0000000..e34d752
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> @@ -0,0 +1,14 @@
> +* Freescale i.MX6UL Touch Controller
> +
> +Required properties:
> +- compatible: must be "fsl,imx6ul-tsc"
> +

What about all the other properties in the example?

> +Example:
> +	&tsc {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tsc>;
> +		status = "okay";
> +		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> +		measure_delay_time = <0xfff>;
> +		pre_charge_time = <0xffff>;

Thiose underscores should be dashes, and all the properties should be
documented.

Mark.
