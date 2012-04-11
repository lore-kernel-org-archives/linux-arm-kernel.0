From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 11 Apr 2012 19:18:33 +0400
Subject: [PATCH 1/2] iommu/exynos: fix runtime pm support
In-Reply-To: <1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
 <1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F85A0C9.7050800@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Marek Szyprowski wrote:

> Fix registration to runtime pw and add missing resume callback.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)

> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b8daf7c..eef924d 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
[...]
> @@ -674,11 +673,28 @@ err_alloc:
>  	return ret;
>  }
>  
> +static int exynos_pm_resume(struct device *dev)
> +{
> +	struct sysmmu_drvdata *data;
> +
> +	data = dev_get_drvdata(dev);

    Why not do it right in the initializer?

WBR, Sergei
