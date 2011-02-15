From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 12:39:29 +0000
Subject: [PATCH v4 15/19] ARM: LPAE: use phys_addr_t instead of
	unsigned long for physical addresses
In-Reply-To: <20110215123522.GH4152@n2100.arm.linux.org.uk>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-16-git-send-email-catalin.marinas@arm.com>
	<20110212102803.GC15616@n2100.arm.linux.org.uk>
	<1297770742.21448.2.camel@e102144-lin.cambridge.arm.com>
	<20110215123522.GH4152@n2100.arm.linux.org.uk>
Message-ID: <1297773569.14691.36.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-02-15 at 12:35 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 15, 2011 at 11:52:22AM +0000, Will Deacon wrote:
> > Excellent! I've split the patch up into four distinct parts, as per your
> > suggestions. I've submitted these to your patch system (6670/1-6673/1)
> > alongside a fixed version of the printf format patch (6669/1) because
> > without that, you get a bunch of compiler warnings.
> 
> Except 6669/1 still suffers from "%#08llx".  For a value of one, that prints:
> 
>         0x000001
> 
> five zeros following the 0x rather than seven.  The width in the format
> string includes the 0x prefix.

Ah, sorry, I only fixed one case and forgot about the rest (and
misleading Will).

-- 
Catalin
