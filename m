From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 6 Nov 2017 13:09:46 -0700
Subject: [PATCH] iommu/mediatek: Fix driver name
In-Reply-To: <20171030113755.32408-1-matthias.bgg@gmail.com>
References: <20171030113755.32408-1-matthias.bgg@gmail.com>
Message-ID: <20171106130946.46a05132@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Oct 2017 12:37:55 +0100
Matthias Brugger <matthias.bgg@gmail.com> wrote:

> There exist two Mediatek iommu drivers for the two different
> generations of the device. But both drivers have the same name
> "mtk-iommu". This breaks the registration of the second driver:
> 
> Error: Driver 'mtk-iommu' is already registered, aborting...
> 
> Fix this by changing the name for first generation to
> "mtk-iommu-v1".
> 
> Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index bc1efbfb9ddf..542930cd183d 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -708,7 +708,7 @@ static struct platform_driver mtk_iommu_driver = {
>  	.probe	= mtk_iommu_probe,
>  	.remove	= mtk_iommu_remove,
>  	.driver	= {
> -		.name = "mtk-iommu",
> +		.name = "mtk-iommu-v1",
>  		.of_match_table = mtk_iommu_of_ids,
>  		.pm = &mtk_iommu_pm_ops,
>  	}

Applied to iommu/updates for v4.15.  Thanks,

Alex
