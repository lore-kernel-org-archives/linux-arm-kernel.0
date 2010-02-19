From: oliver@neukum.org (Oliver Neukum)
Date: Fri, 19 Feb 2010 21:53:22 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266601011.32546.48.camel@e102109-lin.cambridge.arm.com>
References: <1266445892.16346.306.camel@pasglop>
	<1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
	<1266601011.32546.48.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201002192153.22159.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 19. Februar 2010 18:36:51 schrieb Catalin Marinas:
> If a page is already mapped in user space, flush_dcache_page() on ARM
> does the flushing rather than deferring it to update_mmu_cache(). The
> PIO HCD drivers, however, don't call flush_dcache_page(). Is it possible
> that the HCD could transfer data into a page cache page already mapped
> in user space? My understanding is that the scenario above is possible.

Yes, video drivers do that.

	Regards
		Oliver
