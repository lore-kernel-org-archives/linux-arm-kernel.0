From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 15 Nov 2016 12:26:09 +0100
Subject: [PATCH v2 1/5] iommu: Allow taking a reference on a group directly
In-Reply-To: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
References: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
Message-ID: <20161115112609.GA24857@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 05:59:21PM +0000, Robin Murphy wrote:
> iommu_group_get_for_dev() expects that the IOMMU driver's device_group
> callback return a group with a reference held for the given device.
> Whilst allocating a new group is fine, and pci_device_group() correctly
> handles reusing an existing group, there is no general means for IOMMU
> drivers doing their own group lookup to take additional references on an
> existing group pointer without having to also store device pointers or
> resort to elaborate trickery.
> 
> Add an IOMMU-driver-specific function to fill the hole.
> 
> Acked-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Fix the function name; clarify what exactly its callers are fixing.
> 
>  drivers/iommu/iommu.c | 13 +++++++++++++
>  include/linux/iommu.h |  1 +
>  2 files changed, 14 insertions(+)

Applied the series, thanks Robin.
