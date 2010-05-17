From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 May 2010 12:45:57 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <20100517113119.GC29422@n2100.arm.linux.org.uk>
References: <20100516150117.GC23961@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
	<20100517065712.GA23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
	<20100517074329.GB23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA313710@IL-MB01.marvell.com>
	<20100517085751.GD23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3137A1@IL-MB01.marvell.com>
	<20100517100342.GA29422@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31384F@IL-MB01.marvell.com>
	<20100517113119.GC29422@n2100.arm.linux.org.uk>
Message-ID: <1274096757.6053.49.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 12:31 +0100, Russell King - ARM Linux wrote:
> The fact that we have non-ARM ARMv6 CPUs which do prefetch in ways
> we don't know about means that we can't assume that ARMv6 CPUs
> aren't going to have aggressive prefetching.

I agree with this. Maybe we should add a config option for the DMA ops
workaround and state clearly in the help that it doesn't work with
speculative loads into the D-cache. Usually implementations have either
a bit in CP15 ACTLR or some hidden (undocumented) bit somewhere else to
disable the speculative loads.

-- 
Catalin
