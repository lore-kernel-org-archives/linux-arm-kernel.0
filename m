From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 19:25:23 -0700 (MST)
Subject: [PATCH v1 3/9] OMAP2420: hwmod data: add system DMA
In-Reply-To: <1291434246-30716-4-git-send-email-manjugk@ti.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<1291434246-30716-4-git-send-email-manjugk@ti.com>
Message-ID: <alpine.DEB.2.00.1012141922550.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manju

On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:

> Add OMAP2420 DMA hwmod data and also add required
> DMA device attributes.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> +/* dma_system -> L3 */
> +static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
> +	.master		= &omap2420_dma_system_hwmod,
> +	.slave		= &omap2420_l3_main_hwmod,
> +	.clk		= "l3_div_ck",

This clock does not exist on OMAP2420.  Did you test this patch on 2420?

> +/* l4_cfg -> dma_system */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_dma_system_hwmod,
> +	.clk		= "l4_div_ck",

Nor does this clock exist on OMAP2420.

> +static struct omap_hwmod omap2420_dma_system_hwmod = {
> +	.name		= "dma",
> +	.class		= &omap2420_dma_hwmod_class,
> +	.mpu_irqs	= omap2420_dma_system_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dma_system_irqs),
> +	.main_clk	= "l3_div_ck",

And neither does this one.

Please fix these and test on OMAP2420 before sending the fixed patches.


- Paul
