From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 10 Nov 2010 19:32:14 +0530
Subject: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA
	platform Driver
In-Reply-To: <8739rakubj.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
	<8739rakubj.fsf@deeprootsystems.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 3:56 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 10/13] OMAP: DMA: Convert DMA library 
> into DMA platform Driver
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Convert DMA library into DMA platform driver and make use
> > of platform data provided by HWMOD data base for OMAP2PLUS onwards.
> > For OMAP1 processors, the DMA driver in mach-omap uses resource
> > structures for getting platform data.
> >
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> [...]
> 
> > diff --git a/arch/arm/mach-omap2/include/mach/dma.h 
> b/arch/arm/mach-omap2/include/mach/dma.h
> > index d0a7d5b..d13c5c0 100644
> > --- a/arch/arm/mach-omap2/include/mach/dma.h
> > +++ b/arch/arm/mach-omap2/include/mach/dma.h
> > @@ -29,4 +29,7 @@
> >  #ifndef __ASM_ARCH_OMAP2_DMA_H
> >  #define __ASM_ARCH_OMAP2_DMA_H
> >  
> > +/* Should be part of hwmod data base ? */
> > +#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* 
> REVISIT: Is this 32 + 2? */
> > +
> 
> There are no users of this in this patch, all users are removed.

This macro is used in hwmod data base. Do you mean hard coding this
value in hwmod db and remove header?

-Manjunath
