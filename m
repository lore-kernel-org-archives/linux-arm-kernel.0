From: andreas@gaisler.com (Andreas Larsson)
Date: Mon, 12 Jun 2017 10:06:26 +0200
Subject: [PATCH 27/44] sparc: remove leon_dma_ops
In-Reply-To: <20170608132609.32662-28-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-28-hch@lst.de>
Message-ID: <593E4B82.70306@gaisler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-08 15:25, Christoph Hellwig wrote:
> We can just use pci32_dma_ops.
>
> Btw, given that leon is 32-bit and appears to be PCI based, do even need
> the special case for it in get_arch_dma_ops at all?

Hi!

Yes, it is needed. LEON systems are AMBA bus based. The common case here 
is DMA over AMBA buses. Some LEON systems have PCI bridges, but in 
general CONFIG_PCI is not a given.

-- 
Andreas Larsson
Software Engineer
Cobham Gaisler
