From: yibin.gong@nxp.com (Robin Gong)
Date: Thu, 26 Jul 2018 09:51:13 +0000
Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
In-Reply-To: <20180726092220.17250-2-o.rempel@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
Message-ID: <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: 2018?7?26? 17:22
> To: Shawn Guo <shawnguo@kernel.org>; Mark Brown <broonie@kernel.org>;
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org; Andrew Morton
> <akpm@linux-foundation.org>; Liam Girdwood <lgirdwood@gmail.com>;
> Leonard Crestez <leonard.crestez@nxp.com>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Michael
> Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@codeaurora.org>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
> King <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; Robin Gong
> <yibin.gong@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
> fsl,pmic-stby-poweroff property
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> index a45ca67a9d5f..e1308346e00d 100644
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> @@ -6,6 +6,14 @@ Required properties:
>  - interrupts: Should contain CCM interrupt
>  - #clock-cells: Should be <1>
> 
> +Optional properties:
> +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signal
> +  on power off.
> +  Use this property if the SoC should be powered off by external power
> +  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
PMIC_ON_REQ didn't connect to any pin of PMIC in your case? Don't understand
why not follow normal board design guide to power off pmic by PMIC_ON_REQ.
How to power on board again then?
> +  Boards that are designed to initiate poweroff on PMIC_ON_REQ signal
> +should
> +  be using "syscon-poweroff" driver instead.
> +
>  The clock consumer should specify the desired clock by having the clock  ID in
> its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
>  for the full list of i.MX6 Quad and DualLite clock IDs.
> --
> 2.18.0
