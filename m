From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Tue, 13 Jul 2010 17:45:39 +0900
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100713094244.7eb84f1b@lxorguk.ukuu.org.uk>
References: <20100713092012.7c1fe53e@lxorguk.ukuu.org.uk>
	<20100713173028M.fujita.tomonori@lab.ntt.co.jp>
	<20100713094244.7eb84f1b@lxorguk.ukuu.org.uk>
Message-ID: <20100713174519D.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jul 2010 09:42:44 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Tue, 13 Jul 2010 17:30:43 +0900
> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> 
> > On Tue, 13 Jul 2010 09:20:12 +0100
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 
> > > > Why video4linux can't use the DMA API? Doing DMA with vmalloc'ed
> > > > buffers is a thing that we should avoid (there are some exceptions
> > > > like xfs though).
> > > 
> > > Vmalloc is about the only API for creating virtually linear memory areas.
> > > The video stuff really needs that to avoid lots of horrible special cases
> > > when doing buffer processing and the like.
> > > 
> > > Pretty much each driver using it has a pair of functions 'rvmalloc' and
> > > 'rvfree' so given a proper "vmalloc_for_dma()" type interface can easily
> > > be switched
> > 
> > We already have helper functions for DMA with vmap pages,
> > flush_kernel_vmap_range and invalidate_kernel_vmap_range.
> 
> I'm not sure they help at all because the DMA user for these pages isn't
> the video driver - it's the USB layer, and the USB layer isn't
> specifically aware it is being passed vmap pages.

Drivers can tell the USB layer that these are vmapped buffers? Adding
something to struct urb? I might be totally wrong since I don't know
anything about the USB layer.
