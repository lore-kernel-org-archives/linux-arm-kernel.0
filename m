From: hch@lst.de (Christoph Hellwig)
Date: Tue, 10 Jul 2018 20:04:58 +0200
Subject: [RFC PATCH 2/4] ACPI/IORT: Set bus DMA mask as appropriate
In-Reply-To: <c604b3eae4103ee0ad6da84baa1bc893a81ef5f8.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <c604b3eae4103ee0ad6da84baa1bc893a81ef5f8.1531239284.git.robin.murphy@arm.com>
Message-ID: <20180710180458.GC26285@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 06:17:17PM +0100, Robin Murphy wrote:
> When an explicit DMA limit is described by firmware, we need to remember
> it regardless of how drivers might subsequently update their devices'
> masks. The new bus_dma_mask field does that.

Shouldn't we also stop presetting the dma mask after this?
