From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 4 Jan 2017 13:30:28 +0530
Subject: [PATCH] iommu: Drop the of_iommu_{set/get}_ops() interface
In-Reply-To: <20170103173456.18154-1-lorenzo.pieralisi@arm.com>
References: <20170103173456.18154-1-lorenzo.pieralisi@arm.com>
Message-ID: <002c01d26660$a1bf2d40$e53d87c0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

>With the introduction of the new iommu_{register/get}_instance()
>interface in commit e4f10ffe4c9b ("iommu: Make of_iommu_set/get_ops() DT
>agnostic") (based on struct fwnode_handle as look-up token, so firmware
>agnostic) to register IOMMU instances with the core IOMMU layer there is
>no reason to keep the old OF based interface around any longer.
>
>Convert all the IOMMU drivers (and OF IOMMU core code) that rely on the
>of_iommu_{set/get}_ops() to the new kernel interface to register/retrieve
>IOMMU instances and remove the of_iommu_{set/get}_ops() remaining glue
>code in order to complete the interface rework.
>
>Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>Cc: Matthias Brugger <matthias.bgg@gmail.com>
>Cc: Will Deacon <will.deacon@arm.com>
>Cc: Robin Murphy <robin.murphy@arm.com>
>Cc: Joerg Roedel <joro@8bytes.org>
>Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>---
>Exynos, msm and mtk code compile tested only owing to lack of
>test platforms, I would appreciate some help in testing this
>patch on those platforms before merging it even if it is just
>a simple interface conversion.
>

For msm,
Tested-by: Sricharan R <sricharan@codeaurora.org>

Regards,
 Sricharan
