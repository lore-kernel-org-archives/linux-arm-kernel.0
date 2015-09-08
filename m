From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 08 Sep 2015 16:49:20 +0200
Subject: [PATCH v2 1/9] ARM: dts: imx6dql-nitrogen6x: add touchscreen
 support
In-Reply-To: <1441722886-22798-2-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-2-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441723760.3241.26.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 08.09.2015, 16:34 +0200 schrieb Gary Bisson:
> This patch adds the different touchscreens that can be connected using
> the displays available for this board.
> http://boundarydevices.com/product-category/displays/
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index ad16dce..24b667d 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -284,6 +284,22 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_i2c3>;
>  	status = "okay";
> +
> +	egalax_ts at 04 {

I'd prefer to use generic names for the nodes, such as "touchscreen at 04",
and "touchscreen at 38" below.

> +		compatible = "eeti,egalax_ts";
> +		reg = <0x04>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	ft5x06_ts at 38 {
> +		compatible = "edt,edt-ft5x06";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;

This should be wake-gpios and GPIO_ACTIVE_HIGH according to the other
users.

> +	};
>  };
>  
>  &iomuxc {

With those changes,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
