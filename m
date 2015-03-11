From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Mar 2015 09:43:49 +0100
Subject: [PATCH 2/2] iommu: of: enforce const-ness of struct iommu_ops
In-Reply-To: <1425641688-26438-3-git-send-email-will.deacon@arm.com>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
 <1425641688-26438-3-git-send-email-will.deacon@arm.com>
Message-ID: <20150311084347.GC19391@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 11:34:48AM +0000, Will Deacon wrote:
> From: Robin Murphy <Robin.Murphy@arm.com>
> 
> With the pgsize_bitmap removed, there is no compelling reason for
> the remaining callbacks in struct iommu_ops to be mutable, so enforce
> const-ness throughout the core code.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/dma-mapping.h   |  2 +-
>  arch/arm/mm/dma-mapping.c            |  6 +++---
>  arch/arm64/include/asm/dma-mapping.h |  3 ++-
>  drivers/iommu/of_iommu.c             | 12 ++++++------
>  drivers/of/platform.c                |  2 +-
>  include/linux/dma-mapping.h          |  2 +-
>  include/linux/of_iommu.h             |  8 ++++----
>  7 files changed, 18 insertions(+), 17 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/35ce187e/attachment.sig>
