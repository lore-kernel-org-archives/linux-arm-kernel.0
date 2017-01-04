From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 15:19:39 +0000
Subject: [PATCH] iommu: Drop the of_iommu_{set/get}_ops() interface
In-Reply-To: <20170103173456.18154-1-lorenzo.pieralisi@arm.com>
References: <20170103173456.18154-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170104151939.GK18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 05:34:56PM +0000, Lorenzo Pieralisi wrote:
> With the introduction of the new iommu_{register/get}_instance()
> interface in commit e4f10ffe4c9b ("iommu: Make of_iommu_set/get_ops() DT
> agnostic") (based on struct fwnode_handle as look-up token, so firmware
> agnostic) to register IOMMU instances with the core IOMMU layer there is
> no reason to keep the old OF based interface around any longer.
> 
> Convert all the IOMMU drivers (and OF IOMMU core code) that rely on the
> of_iommu_{set/get}_ops() to the new kernel interface to register/retrieve
> IOMMU instances and remove the of_iommu_{set/get}_ops() remaining glue
> code in order to complete the interface rework.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Exynos, msm and mtk code compile tested only owing to lack of
> test platforms, I would appreciate some help in testing this
> patch on those platforms before merging it even if it is just
> a simple interface conversion.
> 
> Thanks,
> Lorenzo
> 
>  drivers/iommu/exynos-iommu.c |  2 +-
>  drivers/iommu/msm_iommu.c    |  2 +-
>  drivers/iommu/mtk_iommu.c    |  2 +-
>  drivers/iommu/of_iommu.c     |  4 ++--
>  include/linux/of_iommu.h     | 11 -----------
>  5 files changed, 5 insertions(+), 16 deletions(-)

Thanks for following up with this cleanup, Lorenzo. I'll queue it locally,
and send it to Joerg for 4.11 if he doesn't apply it manually before then.

Will
