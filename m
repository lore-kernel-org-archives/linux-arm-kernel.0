From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 25 Jun 2018 03:14:39 +0000
Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
In-Reply-To: <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Sunday, June 3, 2018 9:44 AM
> To: shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> mturquette at baylibre.com; sboyd at kernel.org;
> michael at amarulasolutions.com; matteo.lisi at engicam.com
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-clk at vger.kernel.org
> Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
> 
> i.MX6UL has GPIO clock gates in CCM CCGR, add clock property for GPIO driver
> to make sure all GPIO banks work as expected.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> 	no changes since V1.
>  arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 1241972..405e068 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -437,6 +437,7 @@
>  				reg = <0x0209c000 0x4000>;
>  				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_GPIO1>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				interrupt-controller;
> @@ -450,6 +451,7 @@
>  				reg = <0x020a0000 0x4000>;
>  				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_GPIO2>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				interrupt-controller;
> @@ -462,6 +464,7 @@
>  				reg = <0x020a4000 0x4000>;
>  				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_GPIO3>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				interrupt-controller;
> @@ -474,6 +477,7 @@
>  				reg = <0x020a8000 0x4000>;
>  				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_GPIO4>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				interrupt-controller;
> @@ -486,6 +490,7 @@
>  				reg = <0x020ac000 0x4000>;
>  				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_GPIO5>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				interrupt-controller;
> --
> 2.7.4
