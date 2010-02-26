From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Feb 2010 21:00:30 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100226210030.GC23933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2010 at 04:25:21PM +0000, Catalin Marinas wrote:
> For mmap'ed pages (and present in the page cache), is it guaranteed that
> the HCD driver won't write to it once it has been mapped into user
> space? If that's the case, it may solve the problem by just reversing
> the meaning of PG_arch_1 on ARM and assume that a newly allocated page
> has dirty D-cache by default.

I guess we could also set PG_arch_1 in the DMA API as well, to avoid the
unnecessary D cache flushing when clean pages get mapped into userspace.
