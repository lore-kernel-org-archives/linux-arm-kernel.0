From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Thu, 5 Jun 2014 18:31:35 +0000
Subject: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <87aae116ba7a473b85a5a176f300551c@DM2PR03MB479.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> bounces at lists.linux-foundation.org] On Behalf Of Antonios Motakis
> Sent: Thursday, June 05, 2014 10:33 PM
> To: alex.williamson at redhat.com; kvmarm at lists.cs.columbia.edu;
> iommu at lists.linux-foundation.org
> Cc: kvm at vger.kernel.org; eric.auger at linaro.org; open list;
> will.deacon at arm.com; a.rigo at virtualopensystems.com; Yoder Stuart-B08248;
> moderated list:ARM SMMU DRIVER; Antonios Motakis;
> tech at virtualopensystems.com; christoffer.dall at linaro.org
> Subject: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
> IOMMU_CAP_INTR_REMAP
> 
> With an ARM SMMU, interrupt remapping should always be safe from the
> SMMU's point of view, as it is properly handled by the GIC.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> 15ab2af..ff29402 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1544,7 +1544,7 @@ static int arm_smmu_domain_has_cap(struct
> iommu_domain *domain,
>  	if (smmu_domain->root_cfg.smmu->features &
> ARM_SMMU_FEAT_COHERENT_WALK)
>  		caps |= IOMMU_CAP_CACHE_COHERENCY;
> 
> -	caps |= IOMMU_CAP_NOEXEC;
> +	caps |= IOMMU_CAP_NOEXEC | IOMMU_CAP_INTR_REMAP;
> 
>  	return !!(cap & caps);
>  }
Why mention this as an IOMMU capability when IOMMU doesn't support it? Also, wouldn't this depend on the GIC IP version? What are we gaining by adding this IOMMU capability list?

-Varun
