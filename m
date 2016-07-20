From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jul 2016 14:09:01 -0500
Subject: [PATCH 07/12] syscon: dt-bindings: Add documentation for Aspeed
 system control units
In-Reply-To: <1468994313-13538-8-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-8-git-send-email-andrew@aj.id.au>
Message-ID: <20160720190901.GA11147@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 03:28:28PM +0930, Andrew Jeffery wrote:
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-scu.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> new file mode 100644
> index 000000000000..4df798799101
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> @@ -0,0 +1,16 @@
> +The Aspeed System Control Unit manages the global behaviour of the SoC,
> +configuring elements such as clocks, pinmux, and reset.
> +
> +Required properties:
> +- compatible:	One of:
> +		"aspeed,g4-scu", "syscon", "simple-mfd"
> +		"aspeed,g5-scu", "syscon", "simple-mfd"

These (and the pinctrl probably) really need SoC specific compatible 
strings. You can keep these as fallbacks though. These are the parts of 
SoCs that really vary chip to chip.

Rob
