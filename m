From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jun 2014 16:04:51 +0100
Subject: [RFC PATCH v6 03/20] iommu/arm-smmu: add IOMMU_CAP_NOEXEC to the
 ARM SMMU driver
In-Reply-To: <1401987808-23596-4-git-send-email-a.motakis@virtualopensystems.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-4-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <20140616150451.GP16758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 06:03:11PM +0100, Antonios Motakis wrote:
> The ARM SMMU supports the IOMMU_NOEXEC protection flag. Add the
> corresponding IOMMU capability.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d5a2200..15ab2af 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1544,6 +1544,8 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
>  	if (smmu_domain->root_cfg.smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>  		caps |= IOMMU_CAP_CACHE_COHERENCY;
>  
> +	caps |= IOMMU_CAP_NOEXEC;
> +

Just initialise caps to IOMMU_CAP_NOEXEC.

Will
