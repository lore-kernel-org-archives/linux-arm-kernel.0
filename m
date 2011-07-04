From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 04 Jul 2011 16:08:56 -0400 (EDT)
Subject: what about mach-shark?
Message-ID: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Is this used?

While it probably does compile, it is likely to oops soon after boot. I 
notice that it defines UNCACHEABLE_ADDR to 0xdf010000 in 
mach-shark/include/mach/hardware.h which is used by cpu_sa110_do_idle in 
mm/proc-sa110.S, and therefore it must be a virtual address.  However I 
can't find where this 0xdf010000 is actually mapped.

So either no one has been using this for a long time as this is not 
going to run past a schedule to the idle loop, or I'm missing something 
obvious.  If the former I'm proposing to remove mach-shark from the 
tree, if the later I'd like to know where the actual mapping for that 
0xdf010000 is.


Nicolas
