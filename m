From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 19 Aug 2014 01:32:01 +0200
Subject: [PATCH 00/29] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20140818233201.GL9809@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 12:47:28PM +0200, Marek Szyprowski wrote:
>  .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  93 ++-
>  Documentation/power/notifiers.txt                  |  14 +
>  arch/arm/boot/dts/exynos4.dtsi                     | 118 ++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |  23 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  82 +++
>  arch/arm/include/asm/dma-iommu.h                   |  36 ++
>  arch/arm/mach-exynos/pm_domains.c                  |  12 +-
>  arch/arm/mach-integrator/impd1.c                   |   2 +-
>  arch/arm/mm/dma-mapping.c                          |  47 ++
>  drivers/base/bus.c                                 |   4 +-
>  drivers/base/dd.c                                  |  10 +-
>  drivers/base/platform.c                            |   2 +-
>  drivers/base/power/domain.c                        |  70 ++-
>  drivers/clk/samsung/clk-exynos4.c                  |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c           |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |  26 +-
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c        |   1 +
>  drivers/gpu/drm/exynos/exynos_mixer.c              |   1 +
>  drivers/iommu/exynos-iommu.c                       | 663 +++++++++++++--------
>  drivers/iommu/iommu.c                              |   3 +
>  drivers/media/platform/s5p-mfc/s5p_mfc.c           | 107 ++--
>  drivers/pci/host/pci-mvebu.c                       |   2 +-
>  drivers/pci/host/pci-rcar-gen2.c                   |   2 +-
>  drivers/pci/host/pci-tegra.c                       |   2 +-
>  drivers/pci/host/pcie-rcar.c                       |   2 +-
>  drivers/soc/tegra/pmc.c                            |   2 +-
>  include/dt-bindings/clock/exynos4.h                |  10 +-
>  include/linux/device.h                             |  12 +-
>  include/linux/iommu.h                              |   1 +
>  include/linux/pm.h                                 |   2 +
>  include/linux/pm_domain.h                          |  19 +
>  33 files changed, 1016 insertions(+), 356 deletions(-)

This touches a lot of non-iommu stuff. What is your strategy on getting
this in, do you plan to get the non-iommu changes merged first or do you
want to collect the respective Acks and merge this all through one tree?


	Joerg
