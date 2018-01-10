From: ckoenig.leichtzumerken@gmail.com (=?UTF-8?Q?Christian_K=c3=b6nig?=)
Date: Wed, 10 Jan 2018 09:23:08 +0100
Subject: consolidate swiotlb dma_map implementations
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
Message-ID: <5ef96935-f781-96e1-37cc-528d399f0150@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Christian K?nig <christian.koenig@amd.com> for the whole series.

Regards,
Christian.

Am 10.01.2018 um 09:09 schrieb Christoph Hellwig:
> A lot of architectures have essentially identical dma_map_ops
> implementations to use swiotlb.  This series adds new generic
> swiotlb_alloc/free helpers that take the attrs argument exposed
> in dma_map_ops, and which do an enhanced direct allocation
> modelled after x86 and reused from the dma-direct code, and
> then switches most architectures over to it.  The only exceptions
> are mips, which requires additional cache flushing which will
> need a new abstraction, and x86 itself which will be handled in
> a later series with other x86 dma mapping changes.
>
> To support the generic code a few architectures that currently
> use ZONE_DMA/GFP_DMA for <= 32-bit allocations are switched to
> implement ZONE_DMA32 instead.
>
> This series is based on the previously sent series to consolidate
> the direct dma mapping implementation.  A git tree with this
> series as well as the prerequisites is available here:
>
>     git://git.infradead.org/users/hch/misc.git swiotlb
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb
