From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 19:00:34 -0500
Subject: [PATCH 1/6] dt-bindings: ti, edma: Add 66AK2G specific information
In-Reply-To: <20170801044119.16201-2-lokeshvutla@ti.com>
References: <20170801044119.16201-1-lokeshvutla@ti.com>
 <20170801044119.16201-2-lokeshvutla@ti.com>
Message-ID: <20170810000034.vvcdvdez3og6lhux@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:11:14AM +0530, Lokesh Vutla wrote:
> Update ti,edma binding documentation to reflect 66AK2G specific
> properties.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 95 +++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> index 18090e7226b4..05fe2931d025 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -9,7 +9,12 @@ execute the actual DMA tansfer.
>  eDMA3 Channel Controller
>  
>  Required properties:
> -- compatible:	"ti,edma3-tpcc" for the channel controller(s)
> +--------------------
> +- compatible:	Should be:
> +		- "ti,edma3-tpcc" for the channel controller(s) on OMAP,
> +		  AM33xx and AM43xx SoCs.
> +		- "ti,k2g-edma3-tpcc", "ti,edma3-tpcc" for the

If power-domains is mandatory, I don't think the fallback is 
appropriate. Or do you expect it to work if the driver ignores the power 
domain?
