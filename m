From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 21 Jul 2018 13:19:30 +0000
Subject: [PATCH v5 2/4] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <20180721130827.944-3-o.rempel@pengutronix.de>
References: <20180721130827.944-1-o.rempel@pengutronix.de>
 <20180721130827.944-3-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB42117A311BEA1833F842225180500@AM0PR04MB4211.eurprd04.prod.outlook.com>
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
> Subject: [PATCH v5 2/4] dt-bindings: mailbox: imx-mu: add generic MU
> channel support
> 
> Each MU has four pairs of rx/tx data register with four rx/tx interrupts which
> can also be used as a separate channel.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> index 90e4905dfc69..113d6ab931ef 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -22,7 +22,14 @@ Required properties:
>  - reg :		Should contain the registers location and length
>  - interrupts :	Interrupt number. The interrupt specifier format depends
>  		on the interrupt controller parent.
> -- #mbox-cells:  Must be 0. Number of cells in a mailbox
> +- #mbox-cells:  Must be:
> +		0 - for single channel mode. i.MX8* SCU protocol specific.
> +		1 - for multichannel (generic) mode.
> +
> +Optional properties:
> +-------------------
> +- clocks :	phandle to the input clock.
> +- fsl,mu-side-b : Should be set for side B MU.
> 
>  Examples:
>  --------
> --
> 2.18.0
