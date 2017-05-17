From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 17 May 2017 14:51:45 +0200
Subject: [PATCH] iommu/mediatek: include linux/dma-mapping.h
In-Reply-To: <20170511113619.2596882-1-arnd@arndb.de>
References: <20170511113619.2596882-1-arnd@arndb.de>
Message-ID: <20170517125144.GD11068@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 01:35:51PM +0200, Arnd Bergmann wrote:
> The mediatek iommu driver relied on an implicit include of dma-mapping.h,
> but for some reason that is no longer there in 4.12-rc1:
> 
> drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_domain_finalise':
> drivers/iommu/mtk_iommu_v1.c:233:16: error: implicit declaration of function 'dma_zalloc_coherent'; did you mean 'debug_dma_alloc_coherent'? [-Werror=implicit-function-declaration]
> drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_domain_free':
> drivers/iommu/mtk_iommu_v1.c:265:2: error: implicit declaration of function 'dma_free_coherent'; did you mean 'debug_dma_free_coherent'? [-Werror=implicit-function-declaration]
> 
> This adds an explicit #include to make it build again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to iommu/fixes, thanks Arnd.

This was probably another victim of 

	208480b iommu: Remove trace-events include from iommu.h
