From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 21:08:20 +0100
Subject: cpu_suspend does not flush the L2 cache
In-Reply-To: <74C67D49A66F0848B6F4548360B2EDB58DED35BC42@HQMAIL04.nvidia.com>
References: <74C67D49A66F0848B6F4548360B2EDB58DED35BC42@HQMAIL04.nvidia.com>
Message-ID: <20110725200820.GE14955@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 11:49:43AM -0700, Scott Williams wrote:
> In 2.6.39, CPU suspend/resumes crashes if an outer cache controller
> (like a PL310) is configured and enabled. cpu_suspend only flushes
> the L1 cache.

Correct.  cpu_suspend is been a _consolidation_ effort across the various
implementations.  Only one implementation deals with the L2 cache issues
at present.

A bunch of patches have gone in during this merge window to continue
that consolidation effort and improve the cpu_suspend interfaces.
Eventually the L2 cache issues will be dealt with in core code.

So at the moment, platforms are expected to deal with this in their own
suspend finisher code.

FYI, I have no platforms at present with L2 cache and are capable of
suspend.  I'm still waiting on TI for some prototype code for OMAP4
suspend support... until that time, I am unable to progress it further
unless I try to address these issues blind.
