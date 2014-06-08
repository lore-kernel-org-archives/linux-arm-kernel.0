From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 8 Jun 2014 12:31:29 +0200
Subject: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <20140608103129.GC3279@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 07:03:12PM +0200, Antonios Motakis wrote:
> With an ARM SMMU, interrupt remapping should always be safe from the
> SMMU's point of view, as it is properly handled by the GIC.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 15ab2af..ff29402 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1544,7 +1544,7 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
>  	if (smmu_domain->root_cfg.smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>  		caps |= IOMMU_CAP_CACHE_COHERENCY;
>  
> -	caps |= IOMMU_CAP_NOEXEC;
> +	caps |= IOMMU_CAP_NOEXEC | IOMMU_CAP_INTR_REMAP;
>  
>  	return !!(cap & caps);
>  }
> -- 
> 1.8.3.2
> 
What does IOMMU_CAP_INTR_REMAP signify exactly?  Is there docs/examples
somewhere I can look at?  (A quick scan of the Linux souce code doesn't
reveal much, and I'm not sure if this is purely MSI related or what...)

Thanks,
-Christoffer
