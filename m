From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 15:55:57 +0800
Subject: [PATCH 1/3] Documentation: devicetree: add Freescale SCC bindings
In-Reply-To: <1455199485-24458-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1455199485-24458-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20160214075557.GP6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 03:04:43PM +0100, Steffen Trumtrar wrote:
> Add documentation for the Freescale Security Controller (SCC)
> found on i.MX25 SoCs.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  .../devicetree/bindings/crypto/fsl-imx-scc.txt          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt b/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
> new file mode 100644
> index 000000000000..9a15ab8da94f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
> @@ -0,0 +1,17 @@
> +Freescale Security Controller (SCC)
> +
> +Required properties:
> +- compatible : Should be "fsl,imx25-scc".
> +- reg : Should contain register location and length.
> +- interrupts : Should contain interrupt numbers for SCM IRQ and SMN IRQ.
> +
> +Example:
> +
> +	scc: crypto at 53fac000 {
> +		compatible = "fsl,imx25-scc";
> +		reg = <0x53fac000 0x4000>;
> +		clocks = <&clks 111>;
> +		clock-names = "ipg";

Shouldn't these two be mentioned in properties list above too?

Shawn

> +		interrupts = <49>, <50>;
> +		interrupt-names = "scm", "smn";
> +	};
> -- 
> 2.7.0.rc3
> 
> 
