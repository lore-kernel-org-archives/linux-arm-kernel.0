From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Wed, 11 Jun 2014 08:27:54 +0530
Subject: [PATCHv3 0/3] arm:dma-mapping Refactoring iommu dma-mapping code
In-Reply-To: <1402044161-32980-1-git-send-email-ritesh.harjani@gmail.com>
References: <1402044161-32980-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <CAD15agZdquB5Ak5JT_2HRDtrAQ=j-d3UfrJr6ZS9eijD2ibBUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will/Catalin/Marek...

Any comments on this patch series ??

Thanks
Ritesh


On Fri, Jun 6, 2014 at 2:12 PM,  <ritesh.harjani@gmail.com> wrote:
> From: Ritesh Harjani <ritesh.harjani@gmail.com>
>
> Hi All,
>
> This patch series is to refactor iommu related common code from
> arch/arm/dma-mapping.c to lib/iommu-helper.c based on the various
> discussions with the maintainers/experts [1].
>
> Currently the only user of the common lib/iommu-helper code will
> be ARM & ARM64 but later various architecture might try to use this
> iommu lib helper functions.
>
> Major change of this refactoring depends on bringing out struct dma_iommu_mapping
> *mapping variable from arch/arm/include/asm/device.h to include/linux/device.h
> and by moving out complete structure definition of dma_iommu_mapping to
> inclue/linux/iommu-helper.h. These changes are now part of this patch series based
> on Greg's(cc'd) comments[2].
>
> There are 1/2 more function definitions which I can think of moving out, but
> those can be done once this patch series is approved as those are not very
> big changes.
>
> Also, this has been tested and verified on ARM hardware with IOMMU support.
>
> Changes v2 -> v3:
> 1. Included changes in device.h in this patch series[1/3] itself, as Greg
> mentioned that there is no point in approving device.h changes without actual
> refactoring changes gets approved [2].
>
> So, I guess device.h changes should be fine but let Greg confirms it.
>
>
> Links:
> [1]: https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg03458.html
> [2]: https://lkml.org/lkml/2014/6/4/458
>
>
> Ritesh Harjani (3):
>   device.h: arm dma-iommu: Move out dma_iommu_mapping struct
>   arm: dma-mapping: Refactor attach/detach, alloc/free func
>   arm:dma-iommu: Move out complete func defs
>
>  arch/arm/Kconfig                          |  46 +--
>  arch/arm/include/asm/device.h             |   9 -
>  arch/arm/include/asm/dma-iommu.h          |  16 +-
>  arch/arm/mm/dma-mapping.c                 | 578 +++---------------------------
>  drivers/gpu/drm/exynos/exynos_drm_iommu.c |  10 +-
>  include/linux/device.h                    |   5 +
>  include/linux/iommu-helper.h              |  61 ++++
>  lib/iommu-helper.c                        | 562 +++++++++++++++++++++++++++++
>  8 files changed, 710 insertions(+), 577 deletions(-)
>
> --
> 1.8.1.3
>
