From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 17 Jul 2018 05:03:54 +0000
Subject: [PATCH v3 2/3] ARM: dts: imx7s: add i.MX7 messaging unit support
In-Reply-To: <20180716114209.25242-3-o.rempel@pengutronix.de>
References: <20180716114209.25242-1-o.rempel@pengutronix.de>
 <20180716114209.25242-3-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB421178D1CE16778CF9CEACA0805C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Monday, July 16, 2018 7:42 PM
> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-
> imx <linux-imx@nxp.com>
> Subject: [PATCH v3 2/3] ARM: dts: imx7s: add i.MX7 messaging unit support
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
> index ce85b3ca1a55..5bc0d4109da1 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -1001,6 +1001,25 @@
>  				status = "disabled";
>  			};
> 
> +			mu0a: mailbox at 30aa0000 {
> +				compatible = "fsl,imx7s-mu";
> +				reg = <0x30aa0000 0x10000>;
> +				interrupts = <GIC_SPI 88
> IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_MU_ROOT_CLK>;
> +				#mbox-cells = <1>;
> +				fsl,mu-side-a;

Excpet this property which I commented in patch 1, otherwise, this path
Is okay to me.

Regards
Dong Aisheng

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
> +				status = "disabled";
> +			};
> +
>  			usbotg1: usb at 30b10000 {
>  				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
>  				reg = <0x30b10000 0x200>;
> --
> 2.18.0
