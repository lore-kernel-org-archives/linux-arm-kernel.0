From: jhogan@kernel.org (James Hogan)
Date: Wed, 2 May 2018 23:20:18 +0100
Subject: [PATCH 11/13] mips, unicore32: swiotlb doesn't need sg->dma_length
In-Reply-To: <20180425051539.1989-12-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-12-hch@lst.de>
Message-ID: <20180502222017.GC20766@jamesdev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> swiotlb.  swiotlb itself never merges segements and doesn't accesses the
> dma_length field directly, so drop the dependency.

Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
suggest arch ports should enable it for IOMMUs?

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/0634e44b/attachment.sig>
