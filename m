From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 21 Jul 2018 13:24:20 +0000
Subject: [PATCH v5 3/4] ARM: dts: imx7s: add i.MX7 messaging unit support
In-Reply-To: <20180721130827.944-4-o.rempel@pengutronix.de>
References: <20180721130827.944-1-o.rempel@pengutronix.de>
 <20180721130827.944-4-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB42117F1AE6E55BE5D204E71880500@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Saturday, July 21, 2018 9:08 PM
> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-
> imx <linux-imx@nxp.com>
> Subject: [PATCH v5 3/4] ARM: dts: imx7s: add i.MX7 messaging unit support
> 
> Define the Messaging Unit (MU) for i.MX7 in the processor's dtsi.
> The respective driver is added in the next commit.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index ce85b3ca1a55..038e0eafc549 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -1001,6 +1001,25 @@
>  				status = "disabled";
>  			};
> 
> +			mu0a: mailbox at 30aa0000 {
> +				compatible = "fsl,imx7s-mu";

You probably needs a fallback compatible as well as they're the same one.
e.g..
compatible = "fsl,imx7s-mu", "fsl,imx6sx-mu";

Otherwise, you can added my tag.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> +				reg = <0x30aa0000 0x10000>;
> +				interrupts = <GIC_SPI 88
> IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_MU_ROOT_CLK>;
> +				#mbox-cells = <1>;
> +				status = "disabled";
> +			};
> +
> +			mu0b: mailbox at 30ab0000 {
> +				compatible = "fsl,imx7s-mu";
> +				reg = <0x30ab0000 0x10000>;
> +				interrupts = <GIC_SPI 97
> IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_MU_ROOT_CLK>;
> +				#mbox-cells = <1>;
> +				fsl,mu-side-b;
> +				status = "disabled";
> +			};
> +
>  			usbotg1: usb at 30b10000 {
>  				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
>  				reg = <0x30b10000 0x200>;
> --
> 2.18.0
