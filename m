From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Nov 2015 20:35:46 -0600
Subject: [PATCH 1/3] dt-bindings: add multidomain support to i.MX GPC DT
 binding
In-Reply-To: <1448291223-9938-2-git-send-email-l.stach@pengutronix.de>
References: <1448291223-9938-1-git-send-email-l.stach@pengutronix.de>
 <1448291223-9938-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20151125023546.GA2326@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:07:01PM +0100, Lucas Stach wrote:
> This adds a new binding for the Freescale i.MX GPC block, which allows
> to describe multiple power domains in a more natural way. The driver
> will continue to support the old binding for existing DTBs, but new
> features like the additional domains present on i.MX6SX will only be
> usable with the new binding.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../devicetree/bindings/power/fsl,imx-gpc.txt      | 81 ++++++++++++++--------
>  1 file changed, 54 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> index 65cc0345747d..0b777b623812 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> @@ -1,22 +1,41 @@
>  Freescale i.MX General Power Controller
>  =======================================
>  
> -The i.MX6Q General Power Control (GPC) block contains DVFS load tracking
> -counters and Power Gating Control (PGC) for the CPU and PU (GPU/VPU) power
> -domains.
> +The i.MX6 General Power Control (GPC) block contains DVFS load tracking
> +counters and Power Gating Control (PGC).
>  
>  Required properties:
>  - compatible: Should be "fsl,imx6q-gpc" or "fsl,imx6sl-gpc"
>  - reg: should be register base and length as documented in the
>    datasheet
> -- interrupts: Should contain GPC interrupt request 1
> -- pu-supply: Link to the LDO regulator powering the PU power domain
> -- clocks: Clock phandles to devices in the PU power domain that need
> -	  to be enabled during domain power-up for reset propagation.
> -- #power-domain-cells: Should be 1, see below:
> +- interrupts: Should contain GPC interrupts

How many and order?

The rest looks fine.

Rob
