From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Apr 2011 14:05:08 +0300
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <201104180929.33569.arnd@arndb.de>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
	<201104180929.33569.arnd@arndb.de>
Message-ID: <20110418110502.GI12272@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [110418 10:26]:
> On Friday 15 April 2011, Russell King - ARM Linux wrote:
> > On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
> > > From: Ramesh Gupta <grgupta@ti.com>
> > > 
> > > This patch is to flush the iommu page table entries from L1 and L2
> > > caches using dma_map_single. This also simplifies the implementation
> > > by removing the functions  flush_iopgd_range/flush_iopte_range.
> > 
> > No.  This usage is just wrong.  If you're going to use the DMA API then
> > unmap it, otherwise the DMA API debugging will go awol.
> 
> 
> It's also completely upside-down: The iommu support should provide interfaces
> using the dma-mapping API, not use that API to provide a machine specific
> version of the generic interface.
> 
> As far as I can tell, nothing actually uses these drivers, maybe we should just
> remove them before we get any code in the mainline kernel that depends on it.

There is drivers/media/video/omap3isp/isp.c. But if we now
have a generic replacement for this code we should start using it.

Hiroshi, any comments on that?

Regards,

Tony
