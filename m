From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 30 Aug 2017 15:18:52 +0200
Subject: [PATCH 2/3] iommu: mtk: constify iommu_ops
In-Reply-To: <1503922346-25947-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503922346-25947-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170830131852.lpkixnpt2ei4lpka@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 05:42:26PM +0530, Arvind Yadav wrote:
> iommu_ops are not supposed to change at runtime.
> Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
> const iommu_ops provided by <linux/iommu.h>. So mark the non-const
> structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 4 ++--
>  drivers/iommu/mtk_iommu_v1.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

This doesn't apply cleanly to the arm/mediatek branch in the iommu-tree.
Please rebase it against that branch and update the subject to:

	iommu/mediatek: Constify iommu_ops

to match the convention used in the iommu-tree and send it again.


Thanks,

	Joerg
