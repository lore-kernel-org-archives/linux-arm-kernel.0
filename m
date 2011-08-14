From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Aug 2011 08:52:05 +0100
Subject: [PATCH 7/9] ARM: DMA: steal memory for DMA coherent mappings
In-Reply-To: <201108121453.05898.arnd@arndb.de>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<1313146711-1767-8-git-send-email-m.szyprowski@samsung.com>
	<201108121453.05898.arnd@arndb.de>
Message-ID: <20110814075205.GA4986@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 02:53:05PM +0200, Arnd Bergmann wrote:
> On Friday 12 August 2011, Marek Szyprowski wrote:
> > 
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Steal memory from the kernel to provide coherent DMA memory to drivers.
> > This avoids the problem with multiple mappings with differing attributes
> > on later CPUs.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > [m.szyprowski: rebased onto 3.1-rc1]
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Hi Marek,
> 
> Is this the same patch that Russell had to revert because it didn't
> work on some of the older machines, in particular those using
> dmabounce?
> 
> I thought that our discussion ended with the plan to use this only
> for ARMv6+ (which has a problem with double mapping) but not on ARMv5
> and below (which don't have this problem but might need dmabounce).

I thought we'd decided to have a pool of available CMA memory on ARMv6K
to satisfy atomic allocations, which can grow and shrink in size, rather
than setting aside a fixed amount of contiguous system memory.

ARMv6 and ARMv7+ could use CMA directly, and <= ARMv5 can use the existing
allocation method.

Has something changed?
