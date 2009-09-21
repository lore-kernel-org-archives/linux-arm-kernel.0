From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 21 Sep 2009 23:37:59 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <4AB7FE15.4060804@arm.com>
References: <20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
	<4AB7FE15.4060804@arm.com>
Message-ID: <20090921223759.GI14700@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> Of course, we could improve the generic mm/ code but that's not easy to 
> merge as it affects other architectures.

Then again, I seem to recall a troublesome problem with TLBs and
multiple threads in here many months ago that I didn't believe was
fully solved in corner cases, and there's this question I keep
wondering about whether O_DIRECT (used by SQL databases and QEMU among
others) is safe on these ARMs due to DMA to user-space coherence...

Maybe a bit of generic code just has to be changed.

-- Jamie
