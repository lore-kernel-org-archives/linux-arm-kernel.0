From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 29 Feb 2016 16:48:22 +0100
Subject: [PATCH 1/2] iommu/mediatek: select ARM_DMA_USE_IOMMU
In-Reply-To: <1456737553-496245-1-git-send-email-arnd@arndb.de>
References: <1456737553-496245-1-git-send-email-arnd@arndb.de>
Message-ID: <20160229154822.GC13711@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 10:19:06AM +0100, Arnd Bergmann wrote:
> The newly added Mediatek IOMMU driver uses the IOMMU_DMA infrastructure,
> but unlike other such drivers, it does not select 'ARM_DMA_USE_IOMMU',
> which is a prerequisite, leading to a link error:
> 
> warning: (MTK_IOMMU) selects IOMMU_DMA which has unmet direct dependencies (IOMMU_SUPPORT && NEED_SG_DMA_LENGTH)
> drivers/iommu/built-in.o: In function `iommu_put_dma_cookie':
> mtk_iommu.c:(.text+0x11fe): undefined reference to `put_iova_domain'
> drivers/iommu/built-in.o: In function `iommu_dma_init_domain':
> mtk_iommu.c:(.text+0x1316): undefined reference to `init_iova_domain'
> drivers/iommu/built-in.o: In function `__iommu_dma_unmap':
> mtk_iommu.c:(.text+0x1380): undefined reference to `find_iova'
> 
> This adds the same select that the other drivers have. On a related
> note, I wonder if we should just always select ARM_DMA_USE_IOMMU
> whenever any IOMMU driver is enabled. Are there any cases where
> we would enable an IOMMU but not use it?
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
> ---
>  drivers/iommu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied both, thanks.
