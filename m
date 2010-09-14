From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 14 Sep 2010 17:52:06 +0900
Subject: [PATCH 3/5] DMA: reduce the number of memory allocations
In-Reply-To: <20100819160255.GA3948@suse.de>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191634160.26145@axis700.grange>
	<20100819153527.GE2985@suse.de>
	<Pine.LNX.4.64.1008191744560.26145@axis700.grange>
	<20100819160255.GA3948@suse.de>
Message-ID: <20100914085206.GP7336@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 19, 2010 at 09:02:55AM -0700, Greg KH wrote:
> On Thu, Aug 19, 2010 at 05:46:38PM +0200, Guennadi Liakhovetski wrote:
> > On Thu, 19 Aug 2010, Greg KH wrote:
> > 
> > > On Thu, Aug 19, 2010 at 04:40:15PM +0200, Guennadi Liakhovetski wrote:
> > > > Allocate the bitmap in dma_declare_coherent_memory() together with the struct
> > > > dma_coherent_mem object.
> > > 
> > > You describe what you did, but _why_ are you doing it?
> > 
> > Well, to me the subject "_reduce_ the number..." is already a reason 
> > enough - the fewer kmalloc's of 20 bytes - the better, I think. But if you 
> > like, I can update the description too.
> 
> Yes, as I missed that, others might as well :)
> 
Indeed. When this is reposted, it should also include an update for
Documentation/DMA-API.txt. I'm simply not going to take any DMA API
patches if they don't include the documentation update. DMA-API.txt is
one of the few useful parts of Documentation/, we should really strive to
keep it that way.

It would also be nice if on the next iteration DMA API people were Cc'ed,
this would be at least:

	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
	James Bottomley <James.Bottomley@HansenPartnership.com>
