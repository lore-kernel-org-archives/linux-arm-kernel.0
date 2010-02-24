From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 24 Feb 2010 08:16:09 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266979689.23523.1669.camel@pasglop>
References: <1266445892.16346.306.camel@pasglop>
	<201002192153.22159.oliver@neukum.org>
	<1266979689.23523.1669.camel@pasglop>
Message-ID: <201002240816.10178.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 24. Februar 2010 03:48:09 schrieb Benjamin Herrenschmidt:
> On Fri, 2010-02-19 at 21:53 +0100, Oliver Neukum wrote:
> > Am Freitag, 19. Februar 2010 18:36:51 schrieb Catalin Marinas:
> > > If a page is already mapped in user space, flush_dcache_page() on ARM
> > > does the flushing rather than deferring it to update_mmu_cache(). The
> > > PIO HCD drivers, however, don't call flush_dcache_page(). Is it possible
> > > that the HCD could transfer data into a page cache page already mapped
> > > in user space? My understanding is that the scenario above is possible.
> > 
> > Yes, video drivers do that. 
> 
> In which case it would be up to the video driver to call
> flush_dcache_page() (though if it's v4l you are talking about, maybe it
> might make sense to push it into the v4l layer itself).

I don't know. The issue seems quite complex. It would seem better to
centralize it as far as practical. Do you have a wrapper drivers could
call?

	Regards
		Oliver
