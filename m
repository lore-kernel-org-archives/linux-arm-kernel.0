From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 15:39:11 +0100
Subject: [PATCH 2/8] ARM: dma-mapping: implement dma_map_single on top
	of dma_map_page
In-Reply-To: <1308556213-24970-3-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20110620143911.GD26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 09:50:07AM +0200, Marek Szyprowski wrote:
> This patch consolidates dma_map_single and dma_map_page calls. This is
> required to let dma-mapping framework on ARM architecture use common,
> generic dma-mapping helpers.

This breaks DMA API debugging, which requires that dma_map_page and
dma_unmap_page are paired separately from dma_map_single and
dma_unmap_single().

This also breaks dmabounce when used with a highmem-enabled system -
dmabounce refuses the dma_map_page() API but allows the dma_map_single()
API.
