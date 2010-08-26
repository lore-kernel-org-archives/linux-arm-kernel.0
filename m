From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Thu, 26 Aug 2010 12:44:34 +0900
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100826115017.04f6f707.kamezawa.hiroyu@jp.fujitsu.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
	<op.vh0wektv7p4s8u@localhost>
	<20100826115017.04f6f707.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100826124434.6089630d.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010 11:50:17 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
 
> 128MB...too big ? But it's depend on config.
> 
> IBM's ppc guys used 16MB section, and recently, a new interface to shrink
> the number of /sys files are added, maybe usable.
> 
> Something good with this approach will be you can create "cma" memory
> before installing driver.
> 
> But yes, complicated and need some works.
> 
Ah, I need to clarify what I want to say.

With compaction, it's helpful, but you can't get contiguous memory larger
than MAX_ORDER, I think. To get memory larger than MAX_ORDER on demand,
memory hot-plug code has almost all necessary things.

you may able to add
# echo 0xa0000000-0xa80000000 > /sys/devices/system/memory/cma

to get contiguous isolated memory.

BTW, just curious...the memory for cma need not to be saved at
hibernation ? Or drivers has to write its own hibernation ops by driver suspend
udev or some ?



Thanks,
-Kame
