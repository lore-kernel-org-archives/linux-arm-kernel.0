From: andi.kleen@intel.com (Andi Kleen)
Date: Fri, 29 Oct 2010 16:27:41 +0200
Subject: [RFC][PATCH 0/3] big chunk memory allocator v2
In-Reply-To: <op.vlb8bda87p4s8u@pikus>
References: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTim4fFXQKqmFCeR8pvi0SZPXpjDqyOkbV6PYJYkR@mail.gmail.com>
	<op.vlbywq137p4s8u@pikus>
	<20101029103154.GA10823@gargoyle.fritz.box>
	<20101029195900.88559162.kamezawa.hiroyu@jp.fujitsu.com>
	<20101029122928.GA17792@gargoyle.fritz.box>
	<op.vlb8bda87p4s8u@pikus>
Message-ID: <20101029142741.GB19823@gargoyle.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 29, 2010 at 01:43:51PM +0100, Micha? Nazarewicz wrote:
> >>>> (ii) is used only if all other (non-reserved) pages have
> >>>> been allocated.
> 
> >>> That will be near always the case after some uptime, as memory fills up
> >>> with caches. Unless you do early reclaim?
> 
> Hmm... true.  Still the point remains that only movable and reclaimable pages are
> allowed in the marked regions.  This in effect means that from unmovable pages
> point of view, the area is unusable but I havn't thought of any other way to
> guarantee that because of fragmentation, long sequence of free/movable/reclaimable
> pages is available.

Essentially a movable zone as defined today.

That gets you near all the problems of highmem (except for the mapping
problem and you're a bit more flexible in the splits): 

Someone has to decide at boot how much should be movable
and what not, some workloads will run out of space, some may
deadlock when it runs out of management objects, etc.etc. 
Classic highmem had a long string of issues with all of this.

If it was an easy problem it had been long solved, but it isn't really.

-Andi
