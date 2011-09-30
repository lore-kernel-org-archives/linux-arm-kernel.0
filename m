From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Fri, 30 Sep 2011 15:46:43 +0200
Subject: [PATCH v2 5/5] iommu/exynos: Use bus_set_iommu instead of
	register_iommu
In-Reply-To: <017001cc7f43$04a2db60$0de89220$%kim@samsung.com>
References: <017001cc7f43$04a2db60$0de89220$%kim@samsung.com>
Message-ID: <20110930134643.GS2138@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 03:31:49AM -0400, Kukjin Kim wrote:
> From: KyongHo Cho <pullip.cho@samsung.com>
> 
> This replaces register_iommu() with bus_set_iommu() according to the
> suggestion of Joerg Roedel.

This should be part of patch 3 already when the bus_set_iommu() change
is merged. Otherwise it breaks bisectability too.

	Joerg

> 
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/iommu/exynos_iommu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/exynos_iommu.c b/drivers/iommu/exynos_iommu.c
> index d355a2e..e36f7b2 100644
> --- a/drivers/iommu/exynos_iommu.c
> +++ b/drivers/iommu/exynos_iommu.c
> @@ -912,7 +912,7 @@ static int __init exynos_iommu_init(void)
>  	if (!l2table_cachep)
>  		return -ENOMEM;
>  
> -	register_iommu(&exynos_iommu_ops);
> +	bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
>  
>  	return 0;
>  }
> -- 
> 1.7.1
> 
> 

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
