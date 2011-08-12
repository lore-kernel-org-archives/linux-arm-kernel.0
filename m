From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Aug 2011 14:53:05 +0200
Subject: [PATCH 7/9] ARM: DMA: steal memory for DMA coherent mappings
In-Reply-To: <1313146711-1767-8-git-send-email-m.szyprowski@samsung.com>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<1313146711-1767-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201108121453.05898.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 August 2011, Marek Szyprowski wrote:
> 
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Steal memory from the kernel to provide coherent DMA memory to drivers.
> This avoids the problem with multiple mappings with differing attributes
> on later CPUs.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> [m.szyprowski: rebased onto 3.1-rc1]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Hi Marek,

Is this the same patch that Russell had to revert because it didn't
work on some of the older machines, in particular those using
dmabounce?

I thought that our discussion ended with the plan to use this only
for ARMv6+ (which has a problem with double mapping) but not on ARMv5
and below (which don't have this problem but might need dmabounce).

	Arnd
