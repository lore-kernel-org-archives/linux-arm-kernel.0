From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 09:12:54 +0100
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <BANLkTikfXbtsqaw5ZuP_BbDCtsxXOHZs_w@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
	<BANLkTikfXbtsqaw5ZuP_BbDCtsxXOHZs_w@mail.gmail.com>
Message-ID: <20110415081253.GA18952@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 11:24:16AM +0900, KyongHo Cho wrote:
> That means we need to translate logical to physical address and it is
> sometimes not trivial.

What do you mean "sometimes not trivial" ?  The DMA does nothing more
than virt_to_phys(virt) to get the physical address.  It's _that_ simple.

If virt_to_phys(virt) is likely to fail, there's protection in the DMA API
to BUG_ON() in that case.

> Finally, the kernel will contain many similar routines that do same thing.

So when we get coherent DMA, you won't care that the DMA API functions
start doing nothing with caches?
