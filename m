From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 09:30:18 -0600
Subject: [PATCH v3 4/6] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LHC)
In-Reply-To: <20161206025321.1792-5-andrew@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161206025321.1792-5-andrew@aj.id.au>
Message-ID: <20161212153018.lfkicwknikfbzdlf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 01:53:19PM +1100, Andrew Jeffery wrote:
> The LPC bus pinmux configuration on fifth generation Aspeed SoCs depends
> on bits in both the System Control Unit and the LPC Host Controller.
> 
> The Aspeed LPC Host Controller is described as a child node of the
> LPC host-range syscon device for arbitration of access by the host
> controller and pinmux drivers.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index a97131aba446..9de318ef72da 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -109,3 +109,25 @@ lpc: lpc at 1e789000 {
>  	};
>  };
>  
> +Host Node Children
> +==================
> +
> +LPC Host Controller
> +-------------------
> +
> +The Aspeed LPC Host Controller configures the Low Pin Count (LPC) bus behaviour
> +between the host and the baseboard management controller. The registers exist
> +in the "host" portion of the Aspeed LPC controller, which must be the parent of
> +the LPC host controller node.
> +
> +Required properties:
> +- compatible:		"aspeed,ast2500-lhc";
> +- reg:			contains offset/length value of the LHC memory
> +			region.

How many regions? Looks like 2.

> +
> +Example:
> +
> +lhc: lhc at 20 {
> +	compatible = "aspeed,ast2500-lhc";
> +	reg = <0x20 0x24 0x48 0x8>;
> +};
> -- 
> 2.9.3
> 
