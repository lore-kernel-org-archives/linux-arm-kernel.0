From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Fri, 20 Aug 2010 19:35:01 +0900
Subject: [PATCH/RFCv3 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <op.vhp7rxz77p4s8u@localhost>
References: <op.vhp4pws27p4s8u@localhost>
	<20100820155617S.fujita.tomonori@lab.ntt.co.jp>
	<op.vhp7rxz77p4s8u@localhost>
Message-ID: <20100820193328P.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Aug 2010 10:10:45 +0200
**UNKNOWN CHARSET** <m.nazarewicz@samsung.com> wrote:

> > I wrote "similar to the existing API', not "reuse the existing API".
> 
> Yes, but I don't really know what you have in mind.  CMA is similar to various
> APIs in various ways: it's similar to any allocator since it takes
> size in bytes,

why don't take gfp_t flags?

Something like dev_alloc_page is more appropriate name?

Or something similar to dmapool API (mm/dmapool.c) might work
better. The purpose of dmapool API is creating a pool for consistent
memory per device. It's similar to yours, creating a pool for
contiguous memory per device(s)?


> it's similar to coherent since it takes device, it's similar to bootmem/memblock/etc
> since it takes alignment.

I don't think that bootmem/memblock matters here since it's not the
API for drivers.


> > 4k to 40k? I'm not sure. But If I see something like the following, I
> > suspect that there is a better way to integrate this into the existing
> > infrastructure.
> >
> > mm/cma-best-fit.c                   |  407 +++++++++++++++
> 
> Ah, sorry.  I misunderstood you.  I thought you were replying to both 2. and 3.
> above.
> 
> If we only take allocating algorithm then you're right.  Reusing existing one
> should not increase the patch size plus it would be probably a better solution.
> 
> No matter, I would rather first work and core CMA without worrying about reusing
> kmalloc()/coherent/etc. code especially since providing a plugable allocator API
> integration with existing allocating algorithms can be made later on.  To put it
> short I want first to make it work and then improve it.

I'm not sure that's how a new feature is merged.
