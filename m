From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 14:42:13 -0500
Subject: [PATCH v2 1/3] Documentation: devicetree: add Freescale RNGC
 binding
In-Reply-To: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20160318194213.GA10766@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 03:06:38PM +0100, Steffen Trumtrar wrote:
> Add binding documentation for the Freescale RNGC found on
> some i.MX2/3/5 SoCs.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/rng/mxc_rngc.txt | 16 ++++++++++++++++

The MXC name is still not dead?

>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/mxc_rngc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rng/mxc_rngc.txt b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
> new file mode 100644
> index 000000000000..e147a6dde40a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
> @@ -0,0 +1,16 @@
> +Freescale RNGC (Random Number Generator Version C)
> +
> +Required properties:
> +- compatible : Should be "fsl,imx25-rng"

What about i.MX3/5 compatible strings?

> +- reg : Offset and length of the register set of this block
> +- interrupts : the interrupt number for the RNG block
> +- clocks: should contain the RNG clk source
> +
> +Example:
> +
> +rng at 53fb0000 {
> +	compatible = "fsl,imx25-rng";
> +	reg = <0x53fb0000 0x4000>;
> +	interrupts = <22>;
> +	clocks = <&trng_clk>;
> +};
> -- 
> 2.7.0
> 
