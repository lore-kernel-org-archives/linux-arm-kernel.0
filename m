From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Feb 2013 13:48:31 +0530
Subject: [PATCH v7 2/2] ARM: davinci: Remoteproc platform device creation
 data/code
In-Reply-To: <78c80762cae70455b503d78702c3777c3a6d9321.1359684780.git.rtivy@ti.com>
References: <cover.1359684780.git.rtivy@ti.com>
 <78c80762cae70455b503d78702c3777c3a6d9321.1359684780.git.rtivy@ti.com>
Message-ID: <511DEF57.2070208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 2/1/2013 7:54 AM, Robert Tivy wrote:
> Added a new remoteproc platform device for DA8XX.  Contains CMA-based
> reservation of physical memory block.  A new kernel command-line
> parameter has been added to allow boot-time specification of the
> physical memory block.
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>

This looks good to me. Except one minor nit below:

> +static struct platform_device da8xx_dsp = {
> +	.name	= "davinci-rproc",
> +	.id	= 0,

No need to zero initialize here.

> +	.dev	= {
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +	.num_resources	= ARRAY_SIZE(da8xx_rproc_resources),
> +	.resource	= da8xx_rproc_resources,
> +};

You can fix that and add my:

Acked-by: Sekhar Nori <nsekhar@ti.com>

in case this goes from outside of DaVinci tree.

Thanks,
Sekhar
