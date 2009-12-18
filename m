From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 18 Dec 2009 14:15:24 -0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
References: <20091217175416.9317.66257.stgit@e101986-lin>
	<13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
Message-ID: <000001ca7fec$8aca3ec0$a05ebc40$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the feedback.

> From: Woodruff, Richard [mailto:r-woodruff2 at ti.com]
> Sent: 17 December 2009 18:20
 
> Still, the exclusive operations for some systems don't extend beyond an
> ARM smp-cluster. Not all cores and interconnect implementations support
> the range lock.  As such from a SOC point of view SWP still has value
> as it may exist where lwrex/swrex would fail. It is also much lighter
> than using some kind of mailbox alternative.
>
> While the ARM is important to many SOCs its not the whole thing. I've
> seen some side threads where people are busy blindly removing SWP and
> quoting half information.

There is nothing half about SWP/SWPB being deprecated from ARMv6 onwards.
Also, not all systems properly implement the bus locking support required
for SWP to be properly atomic externally.

> My main comment on patch in this regard is to make the point you won't
> be able to fully emulate a SWP with the sequence you posted if you
> consider other cores outside the ARM cluster. Some note to that effect
> would be positive in the description.

I would argue that this is not a property of the patch, but rather the
architectural deprecation of the instruction(s).

However, I take your point. What if I add a comment that this emulation
will not work on uncached memory regions where no global exclusive
monitor is implemented?

Regards
	/
		Leif
