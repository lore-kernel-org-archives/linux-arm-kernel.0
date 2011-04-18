From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 09:29:33 +0200
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <20110414223036.GA7335@n2100.arm.linux.org.uk>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
Message-ID: <201104180929.33569.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2011, Russell King - ARM Linux wrote:
> On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
> > From: Ramesh Gupta <grgupta@ti.com>
> > 
> > This patch is to flush the iommu page table entries from L1 and L2
> > caches using dma_map_single. This also simplifies the implementation
> > by removing the functions  flush_iopgd_range/flush_iopte_range.
> 
> No.  This usage is just wrong.  If you're going to use the DMA API then
> unmap it, otherwise the DMA API debugging will go awol.


It's also completely upside-down: The iommu support should provide interfaces
using the dma-mapping API, not use that API to provide a machine specific
version of the generic interface.

As far as I can tell, nothing actually uses these drivers, maybe we should just
remove them before we get any code in the mainline kernel that depends on it.

	Arnd
