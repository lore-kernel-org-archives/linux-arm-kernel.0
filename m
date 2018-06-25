From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 25 Jun 2018 05:53:59 +0000
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <AM3PR04MB13150F33BC062890B4E87477F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Anson Huang <anson.huang@nxp.com>

I also saw such issue on i.MX6SLL evk board, and also sent out patch for i.MX6SLL.

Anson Huang
Best Regards!


> -----Original Message-----
> From: Robin Gong
> Sent: Monday, June 25, 2018 8:34 PM
> To: shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> Anson Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
> 
> SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should be kept always on.
> But it's disabled after switch disabled interface implemented in pfuze driver
> 'commit 5fe156f1cab4
> ("regulator: pfuze100: add enable/disable for switch")'.Thus, it breaks kernel
> bootup. Add 'regulator-always-on' for SW4.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts
> b/arch/arm/boot/dts/imx6sl-evk.dts
> index 37e792f..798df66 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -199,6 +199,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt = <800000>;
>  				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
>  			};
> 
>  			swbst_reg: swbst {
> --
> 2.7.4
