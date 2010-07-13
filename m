From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Tue, 13 Jul 2010 17:30:43 +0900
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100713092012.7c1fe53e@lxorguk.ukuu.org.uk>
References: <4C3BFDD3.8040209@codeaurora.org>
	<20100713145852C.fujita.tomonori@lab.ntt.co.jp>
	<20100713092012.7c1fe53e@lxorguk.ukuu.org.uk>
Message-ID: <20100713173028M.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jul 2010 09:20:12 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Why video4linux can't use the DMA API? Doing DMA with vmalloc'ed
> > buffers is a thing that we should avoid (there are some exceptions
> > like xfs though).
> 
> Vmalloc is about the only API for creating virtually linear memory areas.
> The video stuff really needs that to avoid lots of horrible special cases
> when doing buffer processing and the like.
> 
> Pretty much each driver using it has a pair of functions 'rvmalloc' and
> 'rvfree' so given a proper "vmalloc_for_dma()" type interface can easily
> be switched

We already have helper functions for DMA with vmap pages,
flush_kernel_vmap_range and invalidate_kernel_vmap_range.

I think that the current DMA API with the above helper functions
should work well drivers that want virtually linear large memory areas
(such as xfs).
