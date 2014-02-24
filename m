From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 24 Feb 2014 14:52:24 +0100
Subject: [PATCH v2 2/2] ARM i.MX6q: Mark VPU and IPU AXI transfers as
 cacheable, increase IPU priority
In-Reply-To: <1393234334-14795-2-git-send-email-p.zabel@pengutronix.de>
References: <1393234334-14795-1-git-send-email-p.zabel@pengutronix.de>
 <1393234334-14795-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1393249944.3091.29.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 24.02.2014, 10:32 +0100 schrieb Philipp Zabel:
> This is needed so that the IPU framebuffer scanout cannot be
> starved by VPU or GPU activity.
> Some boards like the SabreLite and SabreSD seem to set this in
> the DCD already, but the documented register reset values do not
> contain the necessary settings.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v1:
>  - Limited to 80 char lines
>  - Rebased onto Shawn's for-next
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 1e12685..66bd498 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -228,6 +228,39 @@ put_node:
>  	of_node_put(np);
>  }
>  
> +static void __init imx6q_axi_init(void)
> +{
> +	struct regmap *gpr;
> +	unsigned int mask;
> +
> +	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (!IS_ERR(gpr)) {
> +		/*
> +		/* Enable the cacheable attribute of VPU and IPU
  		^^
Sorry about that, please ignore this version.

regards
Philipp
