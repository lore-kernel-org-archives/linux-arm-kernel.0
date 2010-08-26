From: minchan.kim@gmail.com (Minchan Kim)
Date: Thu, 26 Aug 2010 18:29:21 +0900
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <1282810811.1975.246.camel@laptop>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100825173125.0855a6b0@bike.lwn.net>
	<AANLkTinPaq+0MbdW81uoc5_OZ=1Gy_mVYEBnwv8zgOBd@mail.gmail.com>
	<1282810811.1975.246.camel@laptop>
Message-ID: <AANLkTin7EBZw0-WY=NGOmYzZT5Cfy7oWVFBaT2cjK+vZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 26, 2010 at 5:20 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, 2010-08-26 at 11:49 +0900, Minchan Kim wrote:
>> But one of
>> problems is anonymous page which can be has a role of pinned page in
>> non-swapsystem.
>
> Well, compaction can move those around, but if you've got too many of
> them its a simple matter of over-commit and for that we've got the
> OOM-killer ;-)
>

As I said following mail, I said about free space problem.
Of course, compaction could move anon pages into somewhere.
What's is somewhere? At last, it's same zone.
It can prevent fragment problem but not size of free space.
So I mean it would be better to move it into another zone(ex, HIGHMEM)
rather than OOM kill.

-- 
Kind regards,
Minchan Kim
