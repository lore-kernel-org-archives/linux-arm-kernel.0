From: bcrl@kvack.org (Benjamin LaHaise)
Date: Fri, 12 Oct 2012 11:00:45 -0400
Subject: alignment faults in 3.6
In-Reply-To: <1350053300.21172.12319.camel@edumazet-glaptop>
References: <yw1xtxu1nfsn.fsf@unicorn.mansr.com>
 <201210120811.43290.arnd@arndb.de>
 <20121012090321.GA21164@n2100.arm.linux.org.uk>
 <yw1xhaq0nefg.fsf@unicorn.mansr.com>
 <20121012110750.GE21164@n2100.arm.linux.org.uk>
 <yw1x8vbcndlb.fsf@unicorn.mansr.com>
 <20121012114443.GG21164@n2100.arm.linux.org.uk>
 <1350043692.21172.11815.camel@edumazet-glaptop>
 <20121012142254.GG5453@kvack.org>
 <1350053300.21172.12319.camel@edumazet-glaptop>
Message-ID: <20121012150045.GH5453@kvack.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 04:48:20PM +0200, Eric Dumazet wrote:
> > Somehow, I doubt anyone would be willing to walk through all the noise the 
> > faults would likely trigger.
> 
> If this can be mapped to an event that can be used by perf tool, that
> might be useful ?

There are performance counters for the various different types of alignment 
faults supported by perf. Modern x86 makes the vast majority of unaligned 
accesses very low overhead -- the only ones that really hurt are those 
straddling different vm pages, but even those have little cost compared to 
obsolete microarchitectures (*cough* P4 *cough*).

		-ben
-- 
"Thought is the essence of where you are now."
