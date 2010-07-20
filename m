From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 20 Jul 2010 17:17:50 +0200 (CEST)
Subject: [RFC PATCH] ARM: Allow lazy cache flushing via PG_arch_1 for
	highmem pages
In-Reply-To: <alpine.LFD.2.00.1007201458430.24916@xanadu.home>
References: <20100720124102.7163.46919.stgit@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007201458430.24916@xanadu.home>
Message-ID: <alpine.LFD.2.00.1007201715470.25803@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jul 2010, Nicolas Pitre wrote:

> On Tue, 20 Jul 2010, Catalin Marinas wrote:
> 
> > Current flush_dcache_page() implementation does not allow lazy cache
> > flushing for highmem pages (introduced by commit d73cd42) on the
> > assumption that the temporary kmap mapping would disappear. A subsequent
> > commit (7e5a69e) allows __flush_dcache_page() to handle highmem pages so
> > we can allow lazy cache flushing even for highmem pages.
> 
> Actually this has been in the back of my mind for a while.  The 
> reasoning in d73cd42 is flawed, irrespective of the changes in 7e5a69e.  
> Even without the later, it should have been possible to lazily flush the 
> himem pages because they get flushed anyway the moment their virtual 
> mapping goes away through flush_cache_kmaps().  What the second commit 
> is doing is making highmem usable on a VIPT system while it was totally 
> unacounted for and broken before.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

BTW, while I agree with the patch, you might have guessed that I prefer 
that the commit message be changed to more reflect reality.


Nicolas
