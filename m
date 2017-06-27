From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Jun 2017 08:22:42 -0700
Subject: [PATCH v5 4/7] drivers: dma-coherent: Introduce default DMA pool
In-Reply-To: <9ae32e85-dd35-ea04-5c9f-4dc6d1358a99@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-5-git-send-email-vladimir.murzin@arm.com>
 <20170620134932.GB31496@infradead.org>
 <3d5ea779-90a3-f0b5-b9aa-161d4c0855e7@arm.com>
 <20170626094250.GB21570@infradead.org>
 <9ae32e85-dd35-ea04-5c9f-4dc6d1358a99@arm.com>
Message-ID: <20170627152242.GB29664@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 03:36:16PM +0100, Robin Murphy wrote:
> I admit I'm almost in agreement, were it not for the fact that
> dma-contiguous already supports all four combinations of both per-device
> and global pools, and both reserved mem and direct declarations from
> arch/platform code, all through the same interface to boot, and nobody's
> complaining about that. The only real difference for dma-coherent seems
> to be the way it's baked into the existing API.
> 
> If it is just a matter of interfaces, I'd have no objection to exporting
> a separate e.g. dma_alloc_from_global_coherent() or somesuch as a
> conceptually separate interface to dma_coherent_default_memory, which
> the arch code can then call from ->alloc in the same manner they
> currently call dma_alloc_from_contiguous(). That seems like a reasonable
> way to keep the per-device and global pools conceptually distinct
> without needlessly duplicating implementations. In fact, I'm now
> wondering if the regular arm/arm64 atomic pools couldn't also make use
> of such a thing as well...

Ok.  I think I'll just go ahead with the current patches, and then
we'll try to come up with something better later.  I really don't
want it in actual arch code, but I want it controlled from the
dma_map_ops instance instead of from generic code.  There will be
a lot of churn in this area if my plans go ahead, so I think we can
handle it then.
