From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 16 Aug 2011 12:17:30 +0200
Subject: [PATCH 7/9] ARM: DMA: steal memory for DMA coherent mappings
In-Reply-To: <201108121453.05898.arnd@arndb.de>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<1313146711-1767-8-git-send-email-m.szyprowski@samsung.com>
	<201108121453.05898.arnd@arndb.de>
Message-ID: <004301cc5bfd$b50048d0$1f00da70$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, August 12, 2011 2:53 PM Arnd Bergmann wrote:

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

Yes.
 
> I thought that our discussion ended with the plan to use this only
> for ARMv6+ (which has a problem with double mapping) but not on ARMv5
> and below (which don't have this problem but might need dmabounce).

Ok, my fault. I've forgot to mention that this patch was almost ready 
during Linaro meeting, but I didn't manage to post it that time. Of course 
it doesn't fulfill all the agreements from that discussion.

I was only unsure if we should care about the case where CMA is not enabled
for ARMv6+ or not. This patch was prepared in assumption that 
dma_alloc_coherent should work in both cases - with and without CMA.

Now I assume that for ARMv6+ the CMA should be enabled unconditionally.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
