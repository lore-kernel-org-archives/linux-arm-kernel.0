From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 7 Dec 2013 18:23:15 -0500
Subject: [PATCH] mtd: nand: pxa3xx: Disable "armada370-nand" compatible
 support
In-Reply-To: <1386430787-2962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386430787-2962-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131207232315.GC11251@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

I would prefer to call this a 'partial revert of c0f3b8643a6f ...'

On Sat, Dec 07, 2013 at 12:39:47PM -0300, Ezequiel Garcia wrote:
> Currently the "armada370-nand" compatible support is not complete,
> and it was mistake to add it. Instead of completely removing the compatible,
> let's just disable it until all the needed infrastructure is in place.
> 
> Cc: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---


> The compatible was added in:
> 
> commit c0f3b8643a6fa2461d70760ec49d21d2b031d611
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Sat Aug 10 16:34:52 2013 -0300
> 
>     mtd: nand: pxa3xx: Introduce 'marvell,armada370-nand' compatible string

And add this as a oneline in the commit description.

> 
> Which means the fix should be applied in v3.12 and v3.13.
> 
> On Emilio's suggestion, I've opted for the disabling, given all the required
> support is already queued for v3.14. I'll push a patch removing the #if 0
> on top of current l2-mtd.git.
> 
> Brian: Do you think this is OK to be pushed now for v3.13?
> 
>  drivers/mtd/nand/pxa3xx_nand.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 3d143fe..2c5066f 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -333,10 +333,16 @@ static struct of_device_id pxa3xx_nand_dt_ids[] = {
>  		.compatible = "marvell,pxa3xx-nand",
>  		.data       = (void *)PXA3XX_NAND_VARIANT_PXA,
>  	},
> +/*
> + * Currently, the armada370 support is incomplete and can cause the
> + * system to crash. Disable it until all the infrastructure is in place.
> + */
> +#if 0
>  	{
>  		.compatible = "marvell,armada370-nand",
>  		.data       = (void *)PXA3XX_NAND_VARIANT_ARMADA370,
>  	},
> +#endif

I prefer to just remove the lines.

thx,

Jason.
