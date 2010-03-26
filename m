From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 23:03:43 +0000
Subject: RFC: ARM Boot standard for passing device tree blob
In-Reply-To: <fa686aa41003261252u7dc31bb6nca2e77ae8feb4355@mail.gmail.com>
References: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
	<20100325210409.GH24984@n2100.arm.linux.org.uk>
	<1269610665.807.51.camel@e102109-lin.cambridge.arm.com>
	<4BACF238.3040405@firmworks.com>
	<fa686aa41003261113o7cd8612eh9b51904114902a3a@mail.gmail.com>
	<alpine.LFD.2.00.1003261435460.694@xanadu.home>
	<fa686aa41003261252u7dc31bb6nca2e77ae8feb4355@mail.gmail.com>
Message-ID: <20100326230343.GC29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 01:52:24PM -0600, Grant Likely wrote:
> I could change the statement to something like, "virtually tagged or
> indexed data cache(s) must be off", or drop the statement entirely
> since it is implied by the requirement that the MMU must be off.

1. We're not going down the path of having differing conditions for
   different caches; to do so would mean that we'd need to have two
   entirely different sets of code to handle booting in the kernel.

2. No ARM CPU supports having the D-cache enabled without the MMU; the
   data cache needs to be told via the page tables what can be cached
   and what can't - it needs to be told that RAM can cached but IO
   devices must not be.

In short, the MMU must always be off, which in turn means the D-cache
must always be disabled.
