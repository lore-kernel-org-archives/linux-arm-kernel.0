From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jul 2011 22:31:11 +0100
Subject: cpu_suspend does not flush the L2 cache
In-Reply-To: <20110725200820.GE14955@n2100.arm.linux.org.uk>
References: <74C67D49A66F0848B6F4548360B2EDB58DED35BC42@HQMAIL04.nvidia.com>
	<20110725200820.GE14955@n2100.arm.linux.org.uk>
Message-ID: <20110725213111.GB20187@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 09:08:20PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 25, 2011 at 11:49:43AM -0700, Scott Williams wrote:
> > In 2.6.39, CPU suspend/resumes crashes if an outer cache controller
> > (like a PL310) is configured and enabled. cpu_suspend only flushes
> > the L1 cache.
> 
> Correct.  cpu_suspend is been a _consolidation_ effort across the various
> implementations.  Only one implementation deals with the L2 cache issues
> at present.
> 
> A bunch of patches have gone in during this merge window to continue
> that consolidation effort and improve the cpu_suspend interfaces.
> Eventually the L2 cache issues will be dealt with in core code.

I seem to have the outer L2 stuff working pretty well in my latest kexec
series (my vexpress happily ran init=/kexec.sh all weekend). That should
hopefully provide all the necessary hooks in the core code. If not, we
should work something out.

I'll post what I have after the merge window (SMP still not quite there
yet).

Will
