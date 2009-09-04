From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Sep 2009 22:20:24 +0100
Subject: ARM highmem stuff - 5687/1
In-Reply-To: <alpine.LFD.2.00.0909041447020.6044@xanadu.home>
References: <20090902135355.GB12595@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909021009010.6044@xanadu.home>
	<20090904183311.GA10316@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909041447020.6044@xanadu.home>
Message-ID: <20090904212024.GB10316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2009 at 03:33:53PM -0400, Nicolas Pitre wrote:
> On Fri, 4 Sep 2009, Russell King - ARM Linux wrote:
> > In this case, flush_dcache_page() may just set the PG_dcache_dirty bit
> > without flushing anything.
> 
> But only if there is indeed a mapping and it is unmapped.  In which case 
> isn't the flush going to happen before the page gets mapped into user 
> space anyway?

Only if it still has a mapping at that point.

> > I do know that flush_anon_page() was required to stabilise the list server.
> 
> Do you mean __cpuc_flush_dcache_page() inside flush_anon_page()?

I really don't know.  flush_anon_page() wasn't written incrementally, it
was written to allow the accesses as described in cachetlb.txt to work as
expected.  The rationale for this function is further described in commit
03beb07664d768db97bf454ae5c9581cd4737bb4.

I really can't comment any further on this, and I'm really concerned
about changing the current behaviour.  We know what we currently have
works, and given that we've lost a way to test changes in this area
anymore, I think it's definitely a case if leaving well alone.
