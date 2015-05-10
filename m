From: pullip.cho@samsung.com (Cho KyongHo)
Date: Sun, 10 May 2015 21:59:50 +0900
Subject: [PATCH v6 05/25] iommu: exynos: don't read version register on
 every tlb operation
In-Reply-To: <1430727380-10912-6-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150510215950.c4d5dacc81d17c4b470cefb5@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 04 May 2015 10:16:00 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> This patch removes reading of REG_MMU_VERSION register on every tlb
> operation and caches SYSMMU version in driver's internal data.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 3e898504a7c4..3861485f0689 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -213,6 +213,7 @@ struct sysmmu_drvdata {
>  	spinlock_t lock;
>  	struct iommu_domain *domain;
>  	phys_addr_t pgtable;
> +	int version;

Why don't you define its type as unsigned int or u32?

Regards,

KyongHo
