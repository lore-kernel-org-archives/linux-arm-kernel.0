From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Jul 2017 09:20:02 +0200
Subject: [RFC PATCH 1/2] drivers: dma-coherent: Introduce interface for
 default DMA pool
In-Reply-To: <1500281885-3034-2-git-send-email-vladimir.murzin@arm.com>
References: <1500281885-3034-1-git-send-email-vladimir.murzin@arm.com>
 <1500281885-3034-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170719072001.GA20840@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 09:58:04AM +0100, Vladimir Murzin wrote:
> Christoph noticed [1] that default DMA pool in current form overload
> the DMA coherent infrastructure. In reply, Robin suggested to split
> the per-device vs. global pool interfaces, so allocation/release from
> default DMA pool is driven by dma ops implementation.
> 
> This patch implements Robin's idea and provide interface to
> allocate/release/mmap the default/global DMA pool.
> 
> [1] https://lkml.org/lkml/2017/7/7/370
> [2] https://lkml.org/lkml/2017/7/7/431
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

This looks good to me.  I'd just rename the existin *_from_coherent
routines to *_from_dev_coherent.
