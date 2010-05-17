From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 11:03:42 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6
	DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA3137A1@IL-MB01.marvell.com>
References: <1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<20100516150117.GC23961@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
	<20100517065712.GA23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
	<20100517074329.GB23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA313710@IL-MB01.marvell.com>
	<20100517085751.GD23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3137A1@IL-MB01.marvell.com>
Message-ID: <20100517100342.GA29422@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 12:50:01PM +0300, Ronen Shitrit wrote:
> If a speculative prefetch occurs (eg, to prefetch the next ldr) it
> could evict the dirty cache line that the str just wrote to.  Cache
> replacement algorithms aren't always round-robin.
>
> [Ronen Shitrit] only ldr around is the next line, which shouldn't
> evict the current line, so I don't see any issue.

How can you say that the current line won't be evicted?  Do you know
the cache replacement algorithm for your CPU that well?
