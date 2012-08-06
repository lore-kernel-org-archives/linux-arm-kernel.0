From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 6 Aug 2012 14:02:19 -0400 (EDT)
Subject: [PATCH 01/22] ARM: add mechanism for late code patching
In-Reply-To: <20120806132642.GC18957@n2100.arm.linux.org.uk>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-2-git-send-email-cyril@ti.com>
 <20120806111224.GA18957@n2100.arm.linux.org.uk> <501FC44E.1040806@ti.com>
 <20120806132642.GC18957@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1208061356480.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Aug 2012, Russell King - ARM Linux wrote:

> On Mon, Aug 06, 2012 at 09:19:10AM -0400, Cyril Chemparathy wrote:
> > With a flush_cache_all(), we could avoid having to operate a cacheline  
> > at a time, but that clobbers way more than necessary.
> 
> You can't do that, because flush_cache_all() on some CPUs requires the
> proper MMU mappings to be in place, and you can't get those mappings
> in place because you don't have the V:P offsets fixed up in the kernel.
> Welcome to the chicken and egg problem.

This problem is fixed in this case by having the p2v and v2p code sites 
using an out-of-line non optimized computation until those sites are 
runtime patched with the inlined optimized computation we have today.


Nicolas
