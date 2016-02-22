From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 22 Feb 2016 15:28:09 +0530
Subject: [PATCH 3/5] ARM: davinci: dm365: Add dma_slave_map to edma
In-Reply-To: <1454416997-14230-4-git-send-email-peter.ujfalusi@ti.com>
References: <1454416997-14230-1-git-send-email-peter.ujfalusi@ti.com>
 <1454416997-14230-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <56CADBB1.9040908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 February 2016 06:13 PM, Peter Ujfalusi wrote:
> Provide the dma_slave_map to edma which will allow us to move the drivers
> to the new, simpler dmaengine API and we can remove the DMA resources also
> for the devices.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> FIX: dm365

dropped this "note to self" :)

> ---
>  arch/arm/mach-davinci/dm365.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index 01843fbcc9ea..d26dc2b4339a 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -17,6 +17,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/spi/spi.h>
>  #include <linux/platform_data/edma.h>
>  #include <linux/platform_data/gpio-davinci.h>
> @@ -862,9 +863,30 @@ static s8 dm365_queue_priority_mapping[][2] = {
>  	{-1, -1},
>  };
>  
> +static const struct dma_slave_map da365_edma_map[] = {

This should be "dm365_edma_map".

Fixed both locally while applying.

Regards,
Sekhar
