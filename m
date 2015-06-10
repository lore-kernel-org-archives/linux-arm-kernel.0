From: Elliott@hp.com (Elliott, Robert (Server Storage))
Date: Wed, 10 Jun 2015 00:34:57 +0000
Subject: [PATCH 1/2] scatterlist: use sg_phys()
In-Reply-To: <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <94D0CD8314A33A4D9D801C0FE68B40295A977F76@G9W0745.americas.hpqcorp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Dan Williams
> Sent: Tuesday, June 09, 2015 10:27 AM
> Subject: [PATCH 1/2] scatterlist: use sg_phys()
> 
...
> diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
> index ed7ba8a11822..dcb3c594d626 100644
> --- a/arch/microblaze/kernel/dma.c
> +++ b/arch/microblaze/kernel/dma.c
> @@ -61,7 +61,7 @@ static int dma_direct_map_sg(struct device *dev, struct
> scatterlist *sgl,
>  	/* FIXME this part of code is untested */
>  	for_each_sg(sgl, sg, nents, i) {
>  		sg->dma_address = sg_phys(sg);
> -		__dma_sync(page_to_phys(sg_page(sg)) + sg->offset,
> +		__dma_sync(sg_phys(sg),
>  							sg->length, direction);
>  	}

That one ends up with weird indentation.
