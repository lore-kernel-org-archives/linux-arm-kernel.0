From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Oct 2018 09:33:42 -0500
Subject: [PATCH V6 1/3] dt-bindings: fsl: scu: make power domain
 compatible string SoC specific
In-Reply-To: <1539760797-12991-2-git-send-email-aisheng.dong@nxp.com>
References: <1539760797-12991-1-git-send-email-aisheng.dong@nxp.com>
 <1539760797-12991-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181018143342.GA22874@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 07:24:40AM +0000, A.s. Dong wrote:
> As the power domain API might change in the future for new SoCs, although
> in a very low possibility, it's still better to make the compatible string
> more SoC specific to avoid the possible version change for new SoCs.
> 
> Due to there're still no users in kernel, it's safe to update it without
> breaking anything.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

checkpatch says:

WARNING: Missing Signed-off-by: line by nominal patch author 'A.s. Dong <aisheng.dong@nxp.com>'

> ---
> ChangeLog:
> v5->v6:
>  * new patch
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 46d0af1..87fc4b4 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -58,7 +58,7 @@ This binding for the SCU power domain providers uses the generic power
>  domain binding[2].
>  
>  Required properties:
> -- compatible:		Should be "fsl,scu-pd".
> +- compatible:		Should be "fsl,imx8qxp-scu-pd".

You can keep both if you think future SoCs will be compatible.

>  - #address-cells:	Should be 1.
>  - #size-cells:		Should be 0.
>  
> @@ -153,7 +153,7 @@ firmware {
>  		};
>  
>  		imx8qx-pm {
> -			compatible = "fsl,scu-pd";
> +			compatible = "fsl,imx8qxp-scu-pd";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -- 
> 2.7.4
> 
