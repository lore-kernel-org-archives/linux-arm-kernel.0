From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 25 Oct 2016 22:20:40 +0200 (CEST)
Subject: [PATCH 2/3] drivers: iommu: arm-smmu-v3: constify iommu_gather_ops
 structures
In-Reply-To: <1477418772-12184-3-git-send-email-bhumirks@gmail.com>
References: <1477418772-12184-1-git-send-email-bhumirks@gmail.com>
 <1477418772-12184-3-git-send-email-bhumirks@gmail.com>
Message-ID: <alpine.DEB.2.20.1610252220140.2062@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 25 Oct 2016, Bhumika Goyal wrote:

> Check for iommu_gather_ops structures that are only stored in the tlb
> field of an io_pgtable_cfg structure. The tlb field is of type
> const struct iommu_gather_ops *, so iommu_gather_ops structures
> having this property can be declared as const.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 15c01c3..51d8be4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1358,7 +1358,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>  	} while (size -= granule);
>  }
>
> -static struct iommu_gather_ops arm_smmu_gather_ops = {
> +static const struct iommu_gather_ops arm_smmu_gather_ops = {
>  	.tlb_flush_all	= arm_smmu_tlb_inv_context,
>  	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
>  	.tlb_sync	= arm_smmu_tlb_sync,
> --
> 1.9.1
>
>
