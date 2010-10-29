From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Fri, 29 Oct 2010 19:59:00 +0900
Subject: [RFC][PATCH 0/3] big chunk memory allocator v2
In-Reply-To: <20101029103154.GA10823@gargoyle.fritz.box>
References: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTim4fFXQKqmFCeR8pvi0SZPXpjDqyOkbV6PYJYkR@mail.gmail.com>
	<op.vlbywq137p4s8u@pikus>
	<20101029103154.GA10823@gargoyle.fritz.box>
Message-ID: <20101029195900.88559162.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Oct 2010 12:31:54 +0200
Andi Kleen <andi.kleen@intel.com> wrote:

> > When I was posting CMA, it had been suggested to create a new migration type
> > dedicated to contiguous allocations.  I think I already did that and thanks to
> > this new migration type we have (i) an area of memory that only accepts movable
> > and reclaimable pages and 
> 
> Aka highmem next generation :-(
> 

yes. But Nick's new shrink_slab() may be a new help even without
new zone.


> > (ii) is used only if all other (non-reserved) pages have
> > been allocated.
> 
> That will be near always the case after some uptime, as memory fills up
> with caches. Unless you do early reclaim? 
> 

memory migration always do work with alloc_page() for getting migration target
pages. So, memory will be reclaimed if filled by cache.

About my patch, I may have to prealloc all required pages before start.
But I didn't do that at this time.

Thanks,
-Kame
