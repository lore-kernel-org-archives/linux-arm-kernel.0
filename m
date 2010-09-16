From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 16 Sep 2010 13:22:18 +0900
Subject: [PATCH 3/5] DMA: reduce the number of memory allocations
In-Reply-To: <Pine.LNX.4.64.1009150919400.31624@axis700.grange>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191634160.26145@axis700.grange>
	<20100819153527.GE2985@suse.de>
	<Pine.LNX.4.64.1008191744560.26145@axis700.grange>
	<20100819160255.GA3948@suse.de>
	<20100914085206.GP7336@linux-sh.org>
	<Pine.LNX.4.64.1009150919400.31624@axis700.grange>
Message-ID: <20100916042218.GF7266@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 15, 2010 at 09:23:54AM +0200, Guennadi Liakhovetski wrote:
> On Tue, 14 Sep 2010, Paul Mundt wrote:
> > it should also include an update for
> > Documentation/DMA-API.txt. I'm simply not going to take any DMA API
> > patches if they don't include the documentation update. DMA-API.txt is
> > one of the few useful parts of Documentation/, we should really strive to
> > keep it that way.
> 
> I believe, this your comment refers to another related patch of mine:
> 
Yes, sorry about that, this is what I get for having two mutt sessions
open at the same time. I ended up reading one patch and replying to the other.

> Sure, updating the documentation would be the right thing to do here, but 
> FUJITA Tomonori is nacking this patch for 2.6.36, so, we will either have 
> to live with a few broken platforms and drivers until 2.6.37, or we'll 
> have to find another solution, or that NAK has to be reconsidered
> 
I suppose we can live with the breakage for 2.6.36 given that it's just
enforcing behaviour that shouldn't have been relied upon in the first
place. At least there is the opportunity to get things fixed up properly
for 2.6.37, and people that invariably care about it on 2.6.36 will just
end up backporting anyways.
