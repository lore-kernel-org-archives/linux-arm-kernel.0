From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2011 23:30:36 +0100
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
Message-ID: <20110414223036.GA7335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
> From: Ramesh Gupta <grgupta@ti.com>
> 
> This patch is to flush the iommu page table entries from L1 and L2
> caches using dma_map_single. This also simplifies the implementation
> by removing the functions  flush_iopgd_range/flush_iopte_range.

No.  This usage is just wrong.  If you're going to use the DMA API then
unmap it, otherwise the DMA API debugging will go awol.
