From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 15:14:52 +0200
Subject: [PATCH 8/9] ARM: integrate CMA with DMA-mapping subsystem
In-Reply-To: <002b01cc5bf7$0460e350$0d22a9f0$%szyprowski@samsung.com>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<201108121700.30967.arnd@arndb.de>
	<002b01cc5bf7$0460e350$0d22a9f0$%szyprowski@samsung.com>
Message-ID: <201108161514.52953.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 August 2011, Marek Szyprowski wrote:
> On Friday, August 12, 2011 5:01 PM Arnd Bergmann wrote:

> > How about something like
> > 
> >       if (arch_is_coherent() || nommu())
> >               ret = alloc_simple_buffer();
> >       else if (arch_is_v4_v5())
> >               ret = alloc_remap();
> >       else if (gfp & GFP_ATOMIC)
> >               ret = alloc_from_pool();
> >       else
> >               ret = alloc_from_contiguous();
> > 
> > This also allows a natural conversion to dma_map_ops when we get there.
> 
> Ok. Is it ok to enable CMA permanently for ARMv6+? If CMA is left conditional
> the dma pool code will be much more complicated, because it will need to support
> both CMA and non-CMA cases.

I think that is ok, yes.

	Arnd
