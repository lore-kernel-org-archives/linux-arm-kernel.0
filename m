From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 14 Mar 2014 15:29:42 +0530
Subject: [PATCH v11 01/27] iommu/exynos: do not include removed header
In-Reply-To: <20140314140129.68a41cc1bd9e0a48a198ca13@samsung.com>
References: <20140314140129.68a41cc1bd9e0a48a198ca13@samsung.com>
Message-ID: <CAK9yfHzRasE3jroDUZgAa=DN5N=2ZDAxgNiHDCip+f2868BAVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2014 10:31, Cho KyongHo <pullip.cho@samsung.com> wrote:
> Commit 25e9d28d92 (ARM: EXYNOS: remove system mmu initialization from
> exynos tree) removed arch/arm/mach-exynos/mach/sysmmu.h header without
> removing remaining use of it from exynos-iommu driver, thus causing a
> compilation error.
>
> This patch fixes the error by removing respective include line
> from exynos-iommu.c.
>
> CC: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 0740189..4876d35 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -12,6 +12,7 @@
>  #define DEBUG
>  #endif
>
> +#include <linux/kernel.h>

This change doesn't look related to the patch subject/description.

-- 
With warm regards,
Sachin
