From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Dec 2017 12:36:34 -0600
Subject: [RFC 2/5] [media] dt: bindings: Update binding documentation for
 sunxi IR controller
In-Reply-To: <20171216024914.7550-3-embed3d@gmail.com>
References: <20171216024914.7550-1-embed3d@gmail.com>
 <20171216024914.7550-3-embed3d@gmail.com>
Message-ID: <20171216183634.y6e3o725yzbcrbkq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gOn Sat, Dec 16, 2017 at 03:49:11AM +0100, Philipp Rossak wrote:
> This patch updates documentation for Device-Tree bindings for sunxi IR
> controller and adds the new requiered property for the base clock frequency.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/sunxi-ir.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> index 91648c569b1e..5f4960c61245 100644
> --- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
> +++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> @@ -1,12 +1,13 @@
>  Device-Tree bindings for SUNXI IR controller found in sunXi SoC family
>  
>  Required properties:
> -- compatible	    : "allwinner,sun4i-a10-ir" or "allwinner,sun5i-a13-ir"
> -- clocks	    : list of clock specifiers, corresponding to
> -		      entries in clock-names property;
> -- clock-names	    : should contain "apb" and "ir" entries;
> -- interrupts	    : should contain IR IRQ number;
> -- reg		    : should contain IO map address for IR.
> +- compatible	      : "allwinner,sun4i-a10-ir" or "allwinner,sun5i-a13-ir"
> +- clocks	      : list of clock specifiers, corresponding to
> +		        entries in clock-names property;
> +- clock-names	      : should contain "apb" and "ir" entries;
> +- interrupts	      : should contain IR IRQ number;
> +- reg		      : should contain IO map address for IR.
> +- base-clk-frequency  : should contain the base clock frequency

Use clock-frequency or assigned-clocks.

Rob
