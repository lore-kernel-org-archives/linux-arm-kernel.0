From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 10 Nov 2010 22:53:16 +0530
Subject: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA
	platform Driver
In-Reply-To: <87sjz9cfkv.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
	<8739rakubj.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC0@dbde02.ent.ti.com>
	<87sjz9cfkv.fsf@deeprootsystems.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7D81@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 9:54 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 10/13] OMAP: DMA: Convert DMA library 
> into DMA platform Driver
> 
[...]
> >> > +#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* 
> >> REVISIT: Is this 32 + 2? */
> >> > +
> >> 
> >> There are no users of this in this patch, all users are removed.
> >
> > This macro is used in hwmod data base. Do you mean hard coding this
> > value in hwmod db and remove header?
> 
> What I mean is that from a reviewers perspective of this patch, you
> added a new #define that is not used anywhere in this patch.  
> a #define
> should be added along with any users of it.

No. This macro is used in omap2+ hwmod db through plat/dma.h which includes
mach/dma.h

> 
> That being said, the number of channels of the DMA IP sounds like
> something that should indeed be associated with the hwmod as it is a
> fixed HW feature.
If so, I can remove this  macro and hard code in hwmod db.

-Manjunath
