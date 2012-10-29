From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 29 Oct 2012 13:48:46 +0530
Subject: [RFC PATCH v3 11/16] mmc: omap_hsmmc: limit max_segs with the
 EDMA DMAC
In-Reply-To: <1350566815-409-12-git-send-email-mporter@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-12-git-send-email-mporter@ti.com>
Message-ID: <508E3BE6.3070609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 6:56 PM, Matt Porter wrote:
> The EDMA DMAC has a hardware limitation that prevents supporting
> scatter gather lists with any number of segments. Since the EDMA
> DMA Engine driver sets the maximum segments to 16, we do the
> same.
> 
> TODO: this will be replaced once the DMA Engine API supports an
> API to query the DMAC's segment size limit.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b327cd0..52bab01 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1828,6 +1828,16 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>  	 * as we want. */
>  	mmc->max_segs = 1024;
>  
> +	/* Eventually we should get our max_segs limitation for EDMA by
> +	 * querying the dmaengine API */

Nit picking: This is not as per multi-line comment style in
Documentation/CodingStyle.

Thanks,
Sekhar
