From: minchan.kim@gmail.com (Minchan Kim)
Date: Thu, 26 Aug 2010 19:21:55 +0900
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <1282817160.1975.476.camel@laptop>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100825173125.0855a6b0@bike.lwn.net>
	<AANLkTinPaq+0MbdW81uoc5_OZ=1Gy_mVYEBnwv8zgOBd@mail.gmail.com>
	<1282810811.1975.246.camel@laptop>
	<AANLkTin7EBZw0-WY=NGOmYzZT5Cfy7oWVFBaT2cjK+vZ@mail.gmail.com>
	<1282817160.1975.476.camel@laptop>
Message-ID: <AANLkTikS9Bc1NmCCO5w=pT+LBLaeSyk2PBnAry+oDxM8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 26, 2010 at 7:06 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, 2010-08-26 at 18:29 +0900, Minchan Kim wrote:
>> As I said following mail, I said about free space problem.
>> Of course, compaction could move anon pages into somewhere.
>> What's is somewhere? At last, it's same zone.
>> It can prevent fragment problem but not size of free space.
>> So I mean it would be better to move it into another zone(ex, HIGHMEM)
>> rather than OOM kill.
>
> Real machines don't have highmem, highmem sucks!! /me runs

It's another topic.
I agree highmem isn't a gorgeous. But my desktop isn't real machine?
Important thing is that we already have a highmem and many guys
include you(kmap stacking patch :))try to improve highmem problems. :)

>
> Does cross zone movement really matter, I though these crappy devices
> were mostly used on crappy hardware with very limited memory, so pretty
> much everything would be in zone_normal.. no?

No. Until now, many embedded devices have used to small memory. In
that case, only there is a DMA zone in system. But as I know, mobile
phone starts to use big(?) memory like 1G or above sooner or later. So
they starts to use HIGHMEM. Otherwise, 2G/2G space configuration.
Some embedded device uses many thread model to port easily from RTOS.
In that case, they don't have enough address space for application if
it uses 2G/2G model.

So we should care of HIGHMEM in embedded system from now on.

>
> But sure, if there's really a need we can look at maybe doing cross zone
> movement.
>


-- 
Kind regards,
Minchan Kim
