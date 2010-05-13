From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 May 2010 15:15:20 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <20100513135456.GH18984@mvista.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<20100513135456.GH18984@mvista.com>
Message-ID: <1273760120.30713.67.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-13 at 14:54 +0100, George G. Davis wrote:
> Hi,
> 
> On Thu, May 13, 2010 at 09:26:57AM +0100, Catalin Marinas wrote:
> > On Thu, 2010-05-13 at 06:27 +0100, Ronen Shitrit wrote:
> > > Our ARM v6 does have speculative prefetch...
> >
> > That's the I-cache and we should be ok with it. What may affect this
> > patch is speculative fetches into the D-cache.
> 
> prefetch()?

Drivers should not use prefetch (PLD) on memory handed over to a device
for DMA transfers. To me this is like explicitly accessing such memory
during a DMA transfer.

-- 
Catalin
