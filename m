From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 30 Jan 2015 13:40:04 +0100
Subject: [PATCH] iommu: disable on !MMU builds
In-Reply-To: <1685569.C1Ne1erBMA@wuerfel>
References: <1685569.C1Ne1erBMA@wuerfel>
Message-ID: <20150130124004.GF3702@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 03:45:53PM +0100, Arnd Bergmann wrote:
> A lot of the IOMMU support code does not build if the CPU does
> not have an MMU itself, and it's not clear if there is any
> use case for it, so let's just disable it and wait for anybody
> to need it.
> 
> This avoids randconfig errors like
> 
> ../arch/arm/mm/dma-mapping.c: In function '__iommu_alloc_remap':
> ../arch/arm/mm/dma-mapping.c:1278:34: error: 'VM_ARM_DMA_CONSISTENT' undeclared (first use in this function)
>   area = get_vm_area_caller(size, VM_ARM_DMA_CONSISTENT | VM_USERMAP,
>                                   ^
> ../arch/arm/mm/dma-mapping.c:1278:34: note: each undeclared identifier is reported only once for each function it appears in
> ../arch/arm/mm/dma-mapping.c: In function '__atomic_get_pages':
> ../arch/arm/mm/dma-mapping.c:1358:27: error: 'atomic_pool' undeclared (first use in this function)
>   struct dma_pool *pool = &atomic_pool;
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to core branch, thanks.
