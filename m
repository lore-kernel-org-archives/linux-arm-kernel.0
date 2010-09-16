From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 16 Sep 2010 11:58:15 +0900
Subject: [PATCH 3/5] DMA: reduce the number of memory allocations
In-Reply-To: <Pine.LNX.4.64.1009150919400.31624@axis700.grange>
References: <20100819160255.GA3948@suse.de>
	<20100914085206.GP7336@linux-sh.org>
	<Pine.LNX.4.64.1009150919400.31624@axis700.grange>
Message-ID: <20100916115815W.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Sep 2010 09:23:54 +0200 (CEST)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> > it should also include an update for
> > Documentation/DMA-API.txt. I'm simply not going to take any DMA API
> > patches if they don't include the documentation update. DMA-API.txt is
> > one of the few useful parts of Documentation/, we should really strive to
> > keep it that way.
> 
> I believe, this your comment refers to another related patch of mine:
> 
> [RFC][PATCH] add dma_reserve_coherent_memory()/dma_free_reserved_memory() API
> 
> Sure, updating the documentation would be the right thing to do here, but 
> FUJITA Tomonori is nacking this patch for 2.6.36, so, we will either have 

I already explained why the above API is wrong.


> to live with a few broken platforms and drivers until 2.6.37, or we'll 
> have to find another solution, or that NAK has to be reconsidered

Needs to revert the patch that causes the regression. The patch does
the right thing but also breaks some working platforms. You need to
fix "working" platforms that does wrong things before the patch.


> > It would also be nice if on the next iteration DMA API people were Cc'ed,
> > this would be at least:
> > 
> > 	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > 	James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> Right, sorry, added to the CC now, although, this is not the right thread 
> to discuss the proposed new API.

Please send to linux-kernel and linux-arch too.
