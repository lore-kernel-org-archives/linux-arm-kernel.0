From: davem@davemloft.net (David Miller)
Date: Thu, 08 Jun 2017 10:24:05 -0400 (EDT)
Subject: [PATCH 28/44] sparc: remove arch specific dma_supported
 implementations
In-Reply-To: <20170608132609.32662-29-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-29-hch@lst.de>
Message-ID: <20170608.102405.746234218675861415.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoph Hellwig <hch@lst.de>
Date: Thu,  8 Jun 2017 15:25:53 +0200

> Usually dma_supported decisions are done by the dma_map_ops instance.
> Switch sparc to that model by providing a ->dma_supported instance for
> sbus that always returns false, and implementations tailored to the sun4u
> and sun4v cases for sparc64, and leave it unimplemented for PCI on
> sparc32, which means always supported.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
