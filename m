From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jan 2013 18:03:31 +0000
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <alpine.LFD.2.02.1301301223290.6300@xanadu.home>
References: <51093B0B.7010708@arm.com>
 <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
 <20130130162132.GM23505@n2100.arm.linux.org.uk>
 <20130130164535.GN23505@n2100.arm.linux.org.uk>
 <20130130171918.GO23505@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301301223290.6300@xanadu.home>
Message-ID: <20130130180331.GP23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 12:30:06PM -0500, Nicolas Pitre wrote:
> That should probably be:
> 
> 	u32 mask;
> 
> 	for (i = 0; i < 32; i += 4) {
> 		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> 		mask |= (mask >> 16);
> 		mask |= (mask >> 8);
> 		if (mask)
> 			return mask;
> 	}
> 
> I know that the spec says that the GIC should accept byte sized 
> accesses, but that too is known not to work on all implementations.

Well, it really doesn't make that much difference... because from what
I can see the kernel is rather sodded up as it currently stands.

There was a time when the kernel ran on the ARM Realview EB.  But it
doesn't today...

Why is it when I walk away from anything kernel related and then come
back to it, it's always sodded up and rather terminally broken?
