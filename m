From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Dec 2017 11:33:41 +0530
Subject: [PATCH v2 2/3] ARM: davinci: Add dma_mask to dm365's eDMA device
In-Reply-To: <20171205123458.97837-3-amery@hanoverdisplays.com>
References: <2298378f-37d0-0c04-dfe3-4503c58e5456@ti.com>
 <20171204133359.45625-1-amery@hanoverdisplays.com>
 <20171205123458.97837-1-amery@hanoverdisplays.com>
 <20171205123458.97837-3-amery@hanoverdisplays.com>
Message-ID: <d24a3058-37be-43c9-b469-1aea424a5131@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 December 2017 06:04 PM, Alejandro Mery wrote:
> as previously done by cef5b0da4019358cb03c9b0a964d4d63cd7deaf6 for other davinci SoCs
> 
> Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>

Most of the comments on 1/2 apply here. Here is the updated description:

--8<--
ARM: davinci: Add dma_mask to dm365's eDMA device

Add dma_mask to dm365's EDMA device.

Without a valid dma_mask, EDMA on DM365 refuses to
probe.

Fixes: cef5b0da4019 ("ARM: davinci: Add dma_mask to eDMA devices")
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
--8<--

Thanks,
Sekhar

> ---
>  arch/arm/mach-davinci/dm365.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index 9bd17bc77b5c..103316f01a22 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -928,6 +928,7 @@ static struct resource edma_resources[] = {
>  static const struct platform_device_info dm365_edma_device __initconst = {
>  	.name		= "edma",
>  	.id		= 0,
> +	.dma_mask	= DMA_BIT_MASK(32),
>  	.res		= edma_resources,
>  	.num_res	= ARRAY_SIZE(edma_resources),
>  	.data		= &dm365_edma_pdata,
> -- 
> 2.15.0
> 
