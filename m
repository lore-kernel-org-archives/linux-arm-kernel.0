From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Feb 2010 13:48:09 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002192153.22159.oliver@neukum.org>
References: <1266445892.16346.306.camel@pasglop>
	<1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
	<1266601011.32546.48.camel@e102109-lin.cambridge.arm.com>
	<201002192153.22159.oliver@neukum.org>
Message-ID: <1266979689.23523.1669.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-19 at 21:53 +0100, Oliver Neukum wrote:
> Am Freitag, 19. Februar 2010 18:36:51 schrieb Catalin Marinas:
> > If a page is already mapped in user space, flush_dcache_page() on ARM
> > does the flushing rather than deferring it to update_mmu_cache(). The
> > PIO HCD drivers, however, don't call flush_dcache_page(). Is it possible
> > that the HCD could transfer data into a page cache page already mapped
> > in user space? My understanding is that the scenario above is possible.
> 
> Yes, video drivers do that. 

In which case it would be up to the video driver to call
flush_dcache_page() (though if it's v4l you are talking about, maybe it
might make sense to push it into the v4l layer itself).

Cheers,
Ben.
