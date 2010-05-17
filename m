From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 May 2010 12:47:23 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA313852@IL-MB01.marvell.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<1274089860.6053.0.camel@e102109-lin.cambridge.arm.com>
	<1274090255.6053.2.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3137B8@IL-MB01.marvell.com>
	<1274094491.6053.32.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA313852@IL-MB01.marvell.com>
Message-ID: <1274096843.6053.51.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 14:27 +0300, Ronen Shitrit wrote:
> Performance wise we prefer to enable it...
> But it seems to be on the safe side we will disable it.

It's worth doing some benchmarking.

Anyway, if it's a new SoC, you may have the option of implementing IPI
via FIQ and you could broadcast the cache maintenance operations via FIQ
(and avoid potential deadlocks in the kernel).

-- 
Catalin
