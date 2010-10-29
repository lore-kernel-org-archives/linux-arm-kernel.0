From: andi.kleen@intel.com (Andi Kleen)
Date: Fri, 29 Oct 2010 12:31:54 +0200
Subject: [RFC][PATCH 0/3] big chunk memory allocator v2
In-Reply-To: <op.vlbywq137p4s8u@pikus>
References: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTim4fFXQKqmFCeR8pvi0SZPXpjDqyOkbV6PYJYkR@mail.gmail.com>
	<op.vlbywq137p4s8u@pikus>
Message-ID: <20101029103154.GA10823@gargoyle.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> When I was posting CMA, it had been suggested to create a new migration type
> dedicated to contiguous allocations.  I think I already did that and thanks to
> this new migration type we have (i) an area of memory that only accepts movable
> and reclaimable pages and 

Aka highmem next generation :-(

> (ii) is used only if all other (non-reserved) pages have
> been allocated.

That will be near always the case after some uptime, as memory fills up
with caches. Unless you do early reclaim? 

-Andi
