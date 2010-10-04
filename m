From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Mon, 4 Oct 2010 14:45:46 +0530
Subject: [PATCH v4 3/4] OMAP2: DMA: Use errata flag for disabling buffering
In-Reply-To: <1286180294-32618-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
	<1286180294-32618-4-git-send-email-peter.ujfalusi@nokia.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA45@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Monday, October 04, 2010 1:48 PM
> To: Tony Lindgren
> Cc: linux-omap at vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel at lists.infradead.org
> Subject: [PATCH v4 3/4] OMAP2: DMA: Use errata flag for 
> disabling buffering

...

>  
>  /* Errata handling */
> +#define DMA_ERRATA_IFRAME_BUFFERING	(1 << 0)
>  static u16 dma_errata;
>  #define IS_DMA_ERRATA(id)	(dma_errata & (id))
>  

These macros should move to header file since these
macros will be used in mach-omap2/dma.c and plat-omap/dma.c
with upcoming dma hwmod series.

-Manjunath
