From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 21 Jul 2018 13:35:51 +0000
Subject: [PATCH v5 1/4] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <20180721130827.944-2-o.rempel@pengutronix.de>
References: <20180721130827.944-1-o.rempel@pengutronix.de>
 <20180721130827.944-2-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB42114C9A500D344FB9D66A1E80500@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Saturday, July 21, 2018 9:08 PM
> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH v5 1/4] dt-bindings: arm: fsl: add mu binding doc
> 
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> The Messaging Unit module enables two processors within the SoC to
> communicate and coordinate by passing messages (e.g. data, status and
> control) through the MU interface.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Just let you know this patch also depends on another one which is already
Acked by Rob.
If you resend, would you please help pick that one in this series as well?

 [V4,1/5] dt-bindings: mailbox: allow mbox-cells to be equal to 0
https://patchwork.kernel.org/patch/10513197/

Regards
Dong Aisheng

> ---
>  .../devicetree/bindings/mailbox/fsl,mu.txt    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> new file mode 100644
> index 000000000000..90e4905dfc69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -0,0 +1,34 @@
> +NXP i.MX Messaging Unit (MU)
> +--------------------------------------------------------------------
> +
> +The Messaging Unit module enables two processors within the SoC to
> +communicate and coordinate by passing messages (e.g. data, status and
> +control) through the MU interface. The MU also provides the ability for
> +one processor to signal the other processor using interrupts.
> +
> +Because the MU manages the messaging between processors, the MU
> uses
> +different clocks (from each side of the different peripheral buses).
> +Therefore, the MU must synchronize the accesses from one side to the
> +other. The MU accomplishes synchronization using two sets of matching
> +registers (Processor A-facing, Processor B-facing).
> +
> +Messaging Unit Device Node:
> +=============================
> +
> +Required properties:
> +-------------------
> +- compatible :	should be "fsl,<chip>-mu", the supported chips include
> +		imx8qxp, imx8qm.
> +- reg :		Should contain the registers location and length
> +- interrupts :	Interrupt number. The interrupt specifier format depends
> +		on the interrupt controller parent.
> +- #mbox-cells:  Must be 0. Number of cells in a mailbox
> +
> +Examples:
> +--------
> +lsio_mu0: mailbox at 5d1b0000 {
> +	compatible = "fsl,imx8qxp-mu";
> +	reg = <0x0 0x5d1b0000 0x0 0x10000>;
> +	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +	#mbox-cells = <0>;
> +};
> --
> 2.18.0
