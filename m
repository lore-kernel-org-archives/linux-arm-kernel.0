From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 20 Mar 2015 18:58:29 +0200
Subject: [PATCH v2 2/3] iommu: move pgsize_bitmap from struct iommu_ops to
 struct iommu_domain
In-Reply-To: <1426870234-12910-3-git-send-email-will.deacon@arm.com>
References: <1426870234-12910-1-git-send-email-will.deacon@arm.com>
 <1426870234-12910-3-git-send-email-will.deacon@arm.com>
Message-ID: <3215851.bbYbp7PLTr@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thank you for the patch.

On Friday 20 March 2015 16:50:33 Will Deacon wrote:
> struct iommu_ops contains function pointers for IOMMU driver callbacks
> in order to implement the core IOMMU API. Amongst these pointers is
> an unsigned long pgsize_bitmap field, which is problematic because the
> set of supported page sizes is not necessarily the same across all
> instances of a given IOMMU type in the system. Furthermore, the set of
> supported page sizes may be restricted following domain initialisation
> when a particular page table format is chosen for the domain.
> 
> This patch moves the field from iommu_ops into the iommu_domain and
> updates all users accordingly.
> 
> Acked-by: Daniel Kurtz <djkurtz@chromium.org>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

For ipmmu-vmsa and shmobile-iommu,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/amd_iommu.c       |  2 +-
>  drivers/iommu/arm-smmu.c        | 12 +++++-------
>  drivers/iommu/exynos-iommu.c    |  3 ++-
>  drivers/iommu/intel-iommu.c     |  2 +-
>  drivers/iommu/iommu.c           | 16 ++++++++--------
>  drivers/iommu/ipmmu-vmsa.c      |  2 +-
>  drivers/iommu/msm_iommu.c       |  3 ++-
>  drivers/iommu/omap-iommu.c      |  3 ++-
>  drivers/iommu/rockchip-iommu.c  |  2 +-
>  drivers/iommu/shmobile-iommu.c  |  2 +-
>  drivers/iommu/tegra-gart.c      |  2 +-
>  drivers/iommu/tegra-smmu.c      |  3 +--
>  drivers/vfio/vfio_iommu_type1.c |  2 +-
>  include/linux/iommu.h           |  4 +---
>  14 files changed, 28 insertions(+), 30 deletions(-)

-- 
Regards,

Laurent Pinchart
