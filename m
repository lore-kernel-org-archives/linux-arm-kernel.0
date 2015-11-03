From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Nov 2015 13:17:34 +0000
Subject: [RFC] iommu: arm-smmu: correct reference count
In-Reply-To: <1446555557-3097-1-git-send-email-van.freenix@gmail.com>
References: <1446555557-3097-1-git-send-email-van.freenix@gmail.com>
Message-ID: <20151103131734.GE14159@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 08:59:17PM +0800, Peng Fan wrote:
> iommu_group_alloc will initialize the reference count for group to 1.
> iommu_group_add_device also increase the group reference count,
> if nothing bad happends. And we need to add iommu_group_put to
> decrease the reference count for group.
> 
> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
> 
> Not sure whether my understanding is correct or not. I checked rockchip-iommu.c
> exynos-iommu.c and fsl_pamu_domain.c, and they all have iommu_group_put after
> iommu_group_add_device.

Doesn't this pair up with the iommu_group_remove_device in
arm_smmu_remove_device? Are you actually seeing an issue in practice?

Will
