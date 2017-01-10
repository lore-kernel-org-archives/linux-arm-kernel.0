From: hch@lst.de (Christoph Hellwig)
Date: Tue, 10 Jan 2017 15:51:06 +0100
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110115132.GD21598@arm.com>
 <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
Message-ID: <20170110145106.GC27156@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 03:47:25PM +0300, Nikita Yushchenko wrote:
> With this direction, semantics of dma mask becomes even more
> questionable. I'd say dma_mask is candidate for removal (or to move to
> swiotlb's or iommu's local area)

We need the dma mask so that the device can advertise what addresses
the device supports.  Many old devices only support 32-bit DMA addressing,
and some less common ones just 24-bit or other weird ones.
