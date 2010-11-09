From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 09 Nov 2010 14:26:08 -0800
Subject: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA platform
	Driver
In-Reply-To: <1288099513-1854-11-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:10 +0530")
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
Message-ID: <8739rakubj.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Convert DMA library into DMA platform driver and make use
> of platform data provided by HWMOD data base for OMAP2PLUS onwards.
> For OMAP1 processors, the DMA driver in mach-omap uses resource
> structures for getting platform data.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
> index d0a7d5b..d13c5c0 100644
> --- a/arch/arm/mach-omap2/include/mach/dma.h
> +++ b/arch/arm/mach-omap2/include/mach/dma.h
> @@ -29,4 +29,7 @@
>  #ifndef __ASM_ARCH_OMAP2_DMA_H
>  #define __ASM_ARCH_OMAP2_DMA_H
>  
> +/* Should be part of hwmod data base ? */
> +#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
> +

There are no users of this in this patch, all users are removed.

Kevin
