From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 20 Mar 2017 10:43:14 +0100
Subject: [PATCH 7/8] dt-bindings: imx-gpc: correct the DOMAIN_INDEX using
In-Reply-To: <1489990547-1510-8-git-send-email-aisheng.dong@nxp.com>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490002994.2895.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 20.03.2017, 14:15 +0800 schrieb Dong Aisheng:
> Actually DOMAIN_INDEX is not used by the client devices to refer to
> the power domain, it uses phandle. Corrent the binding doc a bit
> to avoid confusing.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Thanks for the catch. Must have slipped through when changing the
binding.

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  Documentation/devicetree/bindings/power/fsl,imx-gpc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> index 06040a4..58d323c 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> @@ -20,8 +20,7 @@ subnodes of the power gating controller 'pgc' node of the GPC and should
>  contain the following:
>  
>  Required properties:
> -- reg: the DOMAIN_INDEX as used by the client devices to refer to this
> -  power domain
> +- reg: Must contain the DOMAIN_INDEX of this power domain
>    The following DOMAIN_INDEX values are valid for i.MX6Q:
>    ARM_DOMAIN     0
>    PU_DOMAIN      1
> @@ -54,6 +53,7 @@ Example:
>  				reg = <0>;
>  				#power-domain-cells = <0>;
>  			};
> +
>  			pd_pu: power-domain at 1 {
>  				reg = <1>;
>  				#power-domain-cells = <0>;
