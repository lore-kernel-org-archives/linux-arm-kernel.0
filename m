From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 06 Jan 2010 16:58:42 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <20100106163234.GC1728@n2100.arm.linux.org.uk>
References: <20100105194328.GG14376@shareable.org>
	<1262795027.18401.28.camel@pc1117.cambridge.arm.com>
	<20100106163234.GC1728@n2100.arm.linux.org.uk>
Message-ID: <1262797122.18401.31.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-06 at 16:32 +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 06, 2010 at 04:23:47PM +0000, Catalin Marinas wrote:
> > On ARMv6 onwards (where this user RO, kernel RO is supported) we cannot
> > easily differentiate between the vectors page and a normal kernel page
> > unless we use another L_PTE_ bit. We need the vectors page to be
> > writable if there is no TLS register in hardware (I guess we could use
> > domain switching to override this though). But on ARMv7 we always have a
> > TLS register, so no need to write to the vectors page.
> 
> That's not the only reason you'd want to write to the vectors page.
> You'll want to write to it to install or change FIQ handlers.

I suspect that's not on a critical path, so the page tables could be
modified temporarily (or use set_fs but I have a patch which tries to
get rid of using the domains).

-- 
Catalin
