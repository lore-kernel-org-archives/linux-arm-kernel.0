From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 14 May 2014 16:13:21 +0200
Subject: [PATCH v4 1/7] reset: sunxi: document sunxi's reset controllers
 bindings
In-Reply-To: <1400071101-30553-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1400071101-30553-1-git-send-email-boris.brezillon@free-electrons.com>
 <1400071101-30553-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1400076801.13056.9.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 14.05.2014, 14:38 +0200 schrieb Boris BREZILLON:
> Add DT bindings documentation for sunxi's reset controllers.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
>  .../bindings/reset/allwinner,sunxi-clock-reset.txt  | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
> new file mode 100644
> index 0000000..c8f7757
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
> @@ -0,0 +1,21 @@
> +Allwinner sunxi Peripheral Reset Controller
> +===========================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: Should be one of the following:
> +  "allwinner,sun6i-a31-ahb1-reset"
> +  "allwinner,sun6i-a31-clock-reset"
> +- reg: should be register base and length as documented in the
> +  datasheet
> +- #reset-cells: 1, see below
> +
> +example:
> +
> +ahb1_rst: reset at 01c202c0 {
> +	#reset-cells = <1>;
> +	compatible = "allwinner,sun6i-a31-ahb1-reset";
> +	reg = <0x01c202c0 0xc>;
> +};
