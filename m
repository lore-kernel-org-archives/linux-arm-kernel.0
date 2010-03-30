From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 30 Mar 2010 01:26:38 +0100
Subject: RFC: ARM Boot standard for passing device tree blob
In-Reply-To: <000001cacf32$66d4b190$4044010a@Emea.Arm.com>
References: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
	<20100325210409.GH24984@n2100.arm.linux.org.uk>
	<1269610665.807.51.camel@e102109-lin.cambridge.arm.com>
	<4BACF238.3040405@firmworks.com>
	<fa686aa41003261113o7cd8612eh9b51904114902a3a@mail.gmail.com>
	<alpine.LFD.2.00.1003261435460.694@xanadu.home>
	<fa686aa41003261252u7dc31bb6nca2e77ae8feb4355@mail.gmail.com>
	<20100326230343.GC29179@n2100.arm.linux.org.uk>
	<000001cacf32$66d4b190$4044010a@Emea.Arm.com>
Message-ID: <20100330002638.GI9876@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave P. Martin wrote:
> Hi
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> > Sent: 26 March 2010 23:04
> > To: Grant Likely
> > Cc: Nicolas Pitre; Mitch Bradley; Catalin Marinas; 
> > devicetree-discuss; Philippe Robin; David Rusling; Jeremy 
> > Kerr; Dave P Martin; linux-arm-kernel at lists.infradead.org
> > Subject: Re: RFC: ARM Boot standard for passing device tree blob
> 
> [...]
> 
> > 2. No ARM CPU supports having the D-cache enabled without the MMU; the
> >    data cache needs to be told via the page tables what can be cached
> >    and what can't - it needs to be told that RAM can cached but IO
> >    devices must not be.
> > 
> > In short, the MMU must always be off, which in turn means the 
> > D-cache must always be disabled.
> 
> Further to this, it's worth pointing out that some systems have external
> caches (such as non-architected L2 cache etc.) which are not integrated into
> the the CPU.  If we allow D-cache to be turned on at all, we would have to
> be clear that external caches must be turned off or configured in a very
> precise way in order to avoid breaking the kernel's bootstrap process.  This
> is especially important when assumptions about the cache arrangement are not
> fixed at build time (in the device tree context, such assumptions generally
> won't be completely fixed).  There's a potential world of problems here---
> it seems best avoided.
> 
> It could be worth clarifying that the L1 I-cache is the _only_ cache which
> is permitted to be enabled at kernel entry, and that all other caches in the
> system must be disabled.

Catalin said that on some platforms, the L2 cache is unavoidably
enabled by the time of kernel boot and it cannot be turned off.
So the above cannot be satisfied.

-- Jamie
