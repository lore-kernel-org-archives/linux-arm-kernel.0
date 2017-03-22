From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 22 Mar 2017 16:19:47 +0100
Subject: [PATCH v2 4/4] iommu/dma: Make PCI window reservation generic
In-Reply-To: <3876a855b7b5ba4684ac3e3af632b817d224c753.1489683129.git.robin.murphy@arm.com>
References: <cover.1489683129.git.robin.murphy@arm.com>
 <3876a855b7b5ba4684ac3e3af632b817d224c753.1489683129.git.robin.murphy@arm.com>
Message-ID: <20170322151947.GE7315@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 05:00:19PM +0000, Robin Murphy wrote:
> Now that we're applying the IOMMU API reserved regions to our IOVA
> domains, we shouldn't need to privately special-case PCI windows, or
> indeed anything else which isn't specific to our iommu-dma layer.
> However, since those aren't IOMMU-specific either, rather than start
> duplicating code into IOMMU drivers let's transform the existing
> function into an iommu_get_resv_regions() helper that they can share.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Notes:
>     v2:
>     - New
> 
>  drivers/iommu/arm-smmu-v3.c |  2 ++
>  drivers/iommu/arm-smmu.c    |  2 ++
>  drivers/iommu/dma-iommu.c   | 38 ++++++++++++++++++++++++++++----------
>  include/linux/dma-iommu.h   |  5 +++++
>  4 files changed, 37 insertions(+), 10 deletions(-)

Applied patches 2-4 to my arm/core branch, thanks.
