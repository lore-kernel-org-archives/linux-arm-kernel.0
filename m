From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Apr 2011 10:21:35 +0100
Subject: [PATCH 4/7] v4l: videobuf2: add IOMMU based DMA memory allocator
In-Reply-To: <00ea01cbfe70$860ca900$9225fb00$%szyprowski@samsung.com>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
	<1303118804-5575-5-git-send-email-m.szyprowski@samsung.com>
	<201104181615.49009.arnd@arndb.de>
	<00ea01cbfe70$860ca900$9225fb00$%szyprowski@samsung.com>
Message-ID: <20110419092135.GD22799@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 11:02:34AM +0200, Marek Szyprowski wrote:
> On Monday, April 18, 2011 4:16 PM Arnd Bergmann wrote:
> > My feeling is that this is not the right abstraction. Why can't you
> > just implement the regular dma-mapping.h interfaces for your IOMMU
> > so that the videobuf code can use the existing allocators?
> 
> I'm not really sure which existing videobuf2 allocators might transparently
> support IOMMU interface yet
> 
> Do you think that all iommu operations can be hidden behind dma_map_single 
> and dma_unmap_single?

That is one of the intentions of the DMA API.
