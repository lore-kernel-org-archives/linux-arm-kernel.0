From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 Aug 2010 10:18:57 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <op.vh0xp8ix7p4s8u@localhost>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<op.vh0xp8ix7p4s8u@localhost>
Message-ID: <1282810737.1975.240.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-26 at 04:40 +0200, Micha? Nazarewicz wrote:
> I think that the biggest problem is fragmentation here.  For instance,
> I think that a situation where there is enough free space but it's
> fragmented so no single contiguous chunk can be allocated is a serious
> problem.  However, I would argue that if there's simply no space left,
> a multimedia device could fail and even though it's not desirable, it
> would not be such a big issue in my eyes.
> 
> So, if only movable or discardable pages are allocated in CMA managed
> regions all should work well.  When a device needs memory discardable
> pages would get freed and movable moved unless there is no space left
> on the device in which case allocation would fail. 

If you'd actually looked at the page allocator you'd see its capable of
doing exactly that!

I has the notion of movable pages, it can defragment free space (called
compaction).

Use it!
