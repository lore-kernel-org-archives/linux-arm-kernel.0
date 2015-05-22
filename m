From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 22 May 2015 13:05:34 +0200
Subject: [PATCH v2] ARM: dts: nitrogen6x: add CAN support
In-Reply-To: <1432230303-3414-1-git-send-email-ps.report@gmx.net>
References: <1432230303-3414-1-git-send-email-ps.report@gmx.net>
Message-ID: <1432292734.3929.64.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Donnerstag, den 21.05.2015, 19:45 +0200 schrieb Peter Seiderer:
> Regulator stuff copied from imx6qdl-tx6.dtsi, pin configuration
> taken from Boundary Devices linux kernel tree ([1] and [2]).
> 
> [1] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> [2] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl.dtsi
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> v2:
>  - fix imx6qdl-nitrogen6x.dtsi url
>  - use real PAD settings (suggested by Fabio Estevam)
>  - remove _1 suffix (suggested by Shawn Guo)
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 32 +++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index fd096dc..d40092e 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -54,6 +54,17 @@
>  			gpio = <&gpio3 22 0>;
>  			enable-active-high;
>  		};
> +
> +		reg_can_xcvr: regulator at 3 {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
> +			regulator-name = "CAN XCVR";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_can_xcvr>;
> +			gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;

According to
Documentation/devicetree/bindings/regulator/fixed-regulator.txt
this should have:
			enable-active-high;

instead of the gpio phandle flag (which is ignored). Otherwise an active
low GPIO is assumed.

regards
Philipp
