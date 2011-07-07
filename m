From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Jul 2011 10:32:12 +0100
Subject: [PATCH v3 01/40] Subject: ARM: mm: proc-macros Add generic
	proc/cache/tlb struct definition macros
In-Reply-To: <20110707082251.GH8286@n2100.arm.linux.org.uk>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-2-git-send-email-dave.martin@linaro.org>
	<20110707082251.GH8286@n2100.arm.linux.org.uk>
Message-ID: <20110707093212.GB9338@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Thu, Jul 07, 2011 at 09:22:51AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 23, 2011 at 06:50:09PM +0100, Dave Martin wrote:
> > +.macro define_cache_functions name:req, default:req, \
> > +		flush_kern_dcache_area, dma_map_area, dma_flush_range
> > +	.align 2
> > + 	.type	\name\()_cache_fns, #object
> > +ENTRY(\name\()_cache_fns)
> > +	.long	\default\()_flush_icache_all
> > +	.long	\default\()_flush_kern_cache_all
> > +	.long	\default\()_flush_user_cache_all
> > +	.long	\default\()_flush_user_cache_range
> > +	.long	\default\()_coherent_kern_range
> > +	.long	\default\()_coherent_user_range
> > +	.ifb \flush_kern_dcache_area
> > +		.long	\default\()_flush_kern_dcache_area
> > +	.else
> > +		.long	\flush_kern_dcache_area
> > +	.endif
> > +	.ifb \dma_map_area
> > +		.long	\default\()_dma_map_area
> > +	.else
> > +		.long	\dma_map_area
> > +	.endif
> > +	.long	\default\()_dma_unmap_area
> > +	.ifb \dma_flush_range
> > +		.long	\default\()_dma_flush_range
> > +	.else
> > +		.long	\dma_flush_range
> > +	.endif
> > +	.size	\name\()_cache_fns, . - \name\()_cache_fns
> > +.endm
> 
> This looks wrong.  The flush_kern_dcache_area and DMA stuff can't be
> any different:

[...]

Would you be happy to pull from my tree if Dave fixes these issues this
week, or would you rather I drop this series for the coming merge window?

Cheers,

Will
