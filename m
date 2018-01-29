From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 11:29:16 -0600
Subject: [PATCH 3/4] dt-bindings: add binding for i.MX8MQ CCM
In-Reply-To: <20180117182950.26460-3-l.stach@pengutronix.de>
References: <20180117182950.26460-1-l.stach@pengutronix.de>
 <20180117182950.26460-3-l.stach@pengutronix.de>
Message-ID: <20180129172916.ek5l5jscsn4qipx5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:29:49PM +0100, Lucas Stach wrote:
> This adds the binding for the i.MX8MQ Clock Controller Module.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../devicetree/bindings/clock/imx8mq-clock.txt       | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8mq-clock.txt b/Documentation/devicetree/bindings/clock/imx8mq-clock.txt
> new file mode 100644
> index 000000000000..c9b0123b80d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx8mq-clock.txt
> @@ -0,0 +1,20 @@
> +* Clock bindings for NXP i.MX8M Quad
> +
> +Required properties:
> +- compatible: Should be "nxp,imx8mq-ccm"
> +- reg: Address and length of the register set
> +- #clock-cells: Should be <1>
> +- clocks: list of clock specifiers, must contain an entry for each required
> +          entry in clock-names
> +- clock-names: should include the following entries:
> +    - "ckil"
> +    - "osc_25m"
> +    - "osc_27m"
> +    - "clk_ext1"
> +    - "clk_ext2"
> +    - "clk_ext3"
> +    - "clk_ext4"
> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx8mq-clock.h

This header belongs in this patch. With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +for the full list of i.MX8M Quad clock IDs.
> -- 
> 2.11.0
> 
