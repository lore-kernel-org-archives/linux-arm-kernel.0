From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 15 Sep 2010 09:23:54 +0200 (CEST)
Subject: [PATCH 3/5] DMA: reduce the number of memory allocations
In-Reply-To: <20100914085206.GP7336@linux-sh.org>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191634160.26145@axis700.grange>
	<20100819153527.GE2985@suse.de>
	<Pine.LNX.4.64.1008191744560.26145@axis700.grange>
	<20100819160255.GA3948@suse.de>
	<20100914085206.GP7336@linux-sh.org>
Message-ID: <Pine.LNX.4.64.1009150919400.31624@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Sep 2010, Paul Mundt wrote:

> On Thu, Aug 19, 2010 at 09:02:55AM -0700, Greg KH wrote:
> > On Thu, Aug 19, 2010 at 05:46:38PM +0200, Guennadi Liakhovetski wrote:
> > > On Thu, 19 Aug 2010, Greg KH wrote:
> > > 
> > > > On Thu, Aug 19, 2010 at 04:40:15PM +0200, Guennadi Liakhovetski wrote:
> > > > > Allocate the bitmap in dma_declare_coherent_memory() together with the struct
> > > > > dma_coherent_mem object.
> > > > 
> > > > You describe what you did, but _why_ are you doing it?
> > > 
> > > Well, to me the subject "_reduce_ the number..." is already a reason 
> > > enough - the fewer kmalloc's of 20 bytes - the better, I think. But if you 
> > > like, I can update the description too.
> > 
> > Yes, as I missed that, others might as well :)
> > 
> Indeed. When this is reposted,

Ok, can do that.

> it should also include an update for
> Documentation/DMA-API.txt. I'm simply not going to take any DMA API
> patches if they don't include the documentation update. DMA-API.txt is
> one of the few useful parts of Documentation/, we should really strive to
> keep it that way.

I believe, this your comment refers to another related patch of mine:

[RFC][PATCH] add dma_reserve_coherent_memory()/dma_free_reserved_memory() API

Sure, updating the documentation would be the right thing to do here, but 
FUJITA Tomonori is nacking this patch for 2.6.36, so, we will either have 
to live with a few broken platforms and drivers until 2.6.37, or we'll 
have to find another solution, or that NAK has to be reconsidered

> It would also be nice if on the next iteration DMA API people were Cc'ed,
> this would be at least:
> 
> 	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> 	James Bottomley <James.Bottomley@HansenPartnership.com>

Right, sorry, added to the CC now, although, this is not the right thread 
to discuss the proposed new API.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
