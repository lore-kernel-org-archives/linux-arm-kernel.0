From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Sep 2016 18:37:36 +0100
Subject: [PATCH v6 00/20] Generic DT bindings for PCI IOMMUs and ARM SMMU
In-Reply-To: <cover.1473173789.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Message-ID: <20160909173736.GF11418@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Sep 06, 2016 at 04:33:33PM +0100, Robin Murphy wrote:
> Here's v6 to address last week's comments. For the sake of honesty I've
> left Lorenzo's tested-by off everything I've changed since, and Eric's
> reviewed-by off patch 19 having non-trivially reworked the guts of it.
> 
> Patch 20 is new, but as it's currently a solution waiting for a problem
> as far as we're aware, oughtn't to get in the way; hopefully the rest is
> in good shape for 4.9 now.
> 
> Branch here, based on Will's iommu/devel queue:
> 
> git://linux-arm.org/linux-rm iommu/generic-v6

I'm pretty happy with this (modulo the binding docs update etc we
discussed off list), however I'm seeing an allmodconfig build failure
with this applied. Error below.

Please can you take a look and send a fixup patch?

Cheers,

Will

--->8

In file included from drivers/gpu/drm/exynos/exynos_drm_drv.c:33:0:
drivers/gpu/drm/exynos/exynos_drm_iommu.h: In function ?__exynos_iommu_create_mapping?:
drivers/gpu/drm/exynos/exynos_drm_iommu.h:69:8: error: too few arguments to function ?iommu_dma_init_domain?
  ret = iommu_dma_init_domain(domain, start, size);
        ^
In file included from drivers/gpu/drm/exynos/exynos_drm_iommu.h:53:0,
                 from drivers/gpu/drm/exynos/exynos_drm_drv.c:33:
./include/linux/dma-iommu.h:33:5: note: declared here
 int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
     ^
make[4]: *** [drivers/gpu/drm/exynos/exynos_drm_drv.o] Error 1
make[3]: *** [drivers/gpu/drm/exynos] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [drivers/gpu/drm] Error 2
make[1]: *** [drivers/gpu] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2
