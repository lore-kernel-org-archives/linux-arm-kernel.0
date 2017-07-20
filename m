From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 20 Jul 2017 16:34:30 -0500
Subject: [PATCH v5 1/3] Documentation: devicetree: add Freescale RNGC
 binding
In-Reply-To: <1500582447-28607-1-git-send-email-martin@kaiser.cx>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
 <1500582447-28607-1-git-send-email-martin@kaiser.cx>
Message-ID: <CAL_Jsq+-PYDw80EXC-eOvvQX7v8O9rVke_0XuM0_Du3xKj_ZWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 3:27 PM, Martin Kaiser <martin@kaiser.cx> wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> Add binding documentation for the Freescale RNGC found on
> some i.MX2/3 SoCs.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> Changes in v5:
>   none
>
> Changes in v4:
>   none
>
> Changes in v3:
>   - add compatible string for imx35
>   - remove imx5 from the commit message,
>     I couldn't find an i.MX SOC that has RNGC

3 versions in 3 days... Give folks time to review.

> Changes in v2:
>   none
>
>  Documentation/devicetree/bindings/rng/mxc_rngc.txt | 16 ++++++++++++++++

Perhaps I wasn't clear. MXC is long dead. Use imx.

>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/mxc_rngc.txt
>
> diff --git a/Documentation/devicetree/bindings/rng/mxc_rngc.txt b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
> new file mode 100644
> index 0000000..5a12ada
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
> @@ -0,0 +1,16 @@
> +Freescale RNGC (Random Number Generator Version C)
> +
> +Required properties:
> +- compatible : Should be "fsl,imx25-rng" or "fsl,imx35-rng"

rngc if that is what the block is called.

Reformat to 1 valid set of compatibles per line.

> +- reg : Offset and length of the register set of this block
> +- interrupts : the interrupt number for the RNG block
> +- clocks: should contain the RNG clk source
> +
> +Example:
> +
> +rng at 53fb0000 {
> +       compatible = "fsl,imx25-rng";
> +       reg = <0x53fb0000 0x4000>;
> +       interrupts = <22>;
> +       clocks = <&trng_clk>;
> +};
> --
> 2.1.4
>
