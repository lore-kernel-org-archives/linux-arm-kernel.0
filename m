From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 Aug 2010 12:06:00 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <AANLkTin7EBZw0-WY=NGOmYzZT5Cfy7oWVFBaT2cjK+vZ@mail.gmail.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100825173125.0855a6b0@bike.lwn.net>
	<AANLkTinPaq+0MbdW81uoc5_OZ=1Gy_mVYEBnwv8zgOBd@mail.gmail.com>
	<1282810811.1975.246.camel@laptop>
	<AANLkTin7EBZw0-WY=NGOmYzZT5Cfy7oWVFBaT2cjK+vZ@mail.gmail.com>
Message-ID: <1282817160.1975.476.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-26 at 18:29 +0900, Minchan Kim wrote:
> As I said following mail, I said about free space problem.
> Of course, compaction could move anon pages into somewhere.
> What's is somewhere? At last, it's same zone.
> It can prevent fragment problem but not size of free space.
> So I mean it would be better to move it into another zone(ex, HIGHMEM)
> rather than OOM kill. 

Real machines don't have highmem, highmem sucks!! /me runs

Does cross zone movement really matter, I though these crappy devices
were mostly used on crappy hardware with very limited memory, so pretty
much everything would be in zone_normal.. no?

But sure, if there's really a need we can look at maybe doing cross zone
movement.
