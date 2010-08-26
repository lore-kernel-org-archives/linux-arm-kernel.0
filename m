From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Thu, 26 Aug 2010 04:12:10 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <op.vh0wektv7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010 02:58:57 +0200, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> Hmm, you may not like this..but how about following kind of interface ?
>
> Now, memoyr hotplug supports following operation to free and _isolate_
> memory region.
> 	# echo offline > /sys/devices/system/memory/memoryX/state
>
> Then, a region of memory will be isolated. (This succeeds if there are free
> memory.)
>
> Add a new interface.
>
> 	% echo offline > /sys/devices/system/memory/memoryX/state
> 	# extract memory from System RAM and make them invisible from buddy allocator.
>
> 	% echo cma > /sys/devices/system/memory/memoryX/state
> 	# move invisible memory to cma.

At this point I need to say that I have no experience with hotplug memory but
I think that for this to make sense the regions of memory would have to be
smaller.  Unless I'm misunderstanding something, the above would convert
a region of sizes in order of GiBs to use for CMA.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
