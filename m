From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Nov 2013 12:06:00 +0000
Subject: CMA on AArch64
In-Reply-To: <528D2C7E.2010107@codeaurora.org>
References: <528D2C7E.2010107@codeaurora.org>
Message-ID: <20131121120559.GC22663@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Nov 20, 2013 at 09:41:18PM +0000, Laura Abbott wrote:
> I noticed there is currently no CMA support for AArch64. Is this already 
> on someone's TODO list or is this still open?

It's more like a wish list but there were other things that took
priority. The arm64 DMA mapping code currently only supports swiotlb and
our next plan is for IOMMU mapping. But I would like parts of the DMA
IOMMU code under arch/arm to be made into a library (similar to the
lib/swiotlb.c) so that other architectures can easily make use of it.

Yet another feature is DMA cache coherency management (primarily
streaming DMA) and I have a patch but I want this driven via DT rather
than drivers or SoC code calling set_dma_ops explicitly (the bindings
definition is work in progress).

Anyway, I think the CMA support wouldn't interfere much with the above
and could be merged. If you have time, please feel free to send some
patches ;).

-- 
Catalin
