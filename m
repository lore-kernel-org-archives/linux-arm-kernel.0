From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 08 Sep 2015 08:58:03 +0200
Subject: [PATCH 1/4] ARM: dts: imx6dql-nitrogen6x: add touchscreen support
In-Reply-To: <1441645069-27263-2-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441645069-27263-2-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441695483.3241.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

Am Montag, den 07.09.2015, 18:57 +0200 schrieb Gary Bisson:
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
> index ad16dce..ec9da5e 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -284,6 +284,22 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_i2c3>;
>  	status = "okay";
> +
> +	egalax_ts at 04 {
> +		compatible = "eeti,egalax_ts";
> +		reg = <0x04>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 2>;

Please use IRQ_TYPE_EDGE_FALLING here.

> +		wakeup-gpios = <&gpio1 9 0>;

And that would be GPIO_ACTIVE_HIGH. Should this be changed to
GPIO_ACTIVE_LOW instead? From other device tree files and from what the
driver does, it looks as if a wakeup is issued by forcing a falling edge
on the IRQ pin.

> +	};
> +
> +	ft5x06_ts at 38 {
> +		compatible = "edt,edt-ft5x06";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 2>;

IRQ_TYPE_EDGE_FALLING

> +		wakeup-gpios = <&gpio1 9 0>;

GPIO_ACTIVE_HIGH

> +	};
>  };

best regards
Philipp
