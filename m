From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 15:40:12 +0100
Subject: [PATCH 4/8] ARM: dma-mapping: implement dma sg methods on top
	of generic dma ops
In-Reply-To: <1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20110620144012.GE26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 09:50:09AM +0200, Marek Szyprowski wrote:
> This patch converts all dma_sg methods to be generic (independent of the
> current DMA mapping implementation for ARM architecture). All dma sg
> operations are now implemented on top of respective
> dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.

No.  We really don't want to do this.  If we want to move the dsb() out
of the mapping functions (which I have a patch for) to avoid doing a
dsb() on each and every sg segment, then we must not use the generic
stuff.
