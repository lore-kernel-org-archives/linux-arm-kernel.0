From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 13 Dec 2016 12:20:24 +0000
Subject: [PATCH V7 7/8] iommu/arm-smmu: Set privileged attribute to
 'default' instead of 'unprivileged'
In-Reply-To: <1481567927-14791-8-git-send-email-sricharan@codeaurora.org>
References: <1481567927-14791-1-git-send-email-sricharan@codeaurora.org>
 <1481567927-14791-8-git-send-email-sricharan@codeaurora.org>
Message-ID: <03731ccb-dad0-6e0b-577b-4cd8e47717c0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/16 18:38, Sricharan R wrote:
> Currently the driver sets all the device transactions privileges
> to UNPRIVILEGED, but there are cases where the iommu masters wants
> to isolate privileged supervisor and unprivileged user.
> So don't override the privileged setting to unprivileged, instead
> set it to default as incoming and let it be controlled by the pagetable
> settings.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Since everything else has already got my tags on it:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I'd say the whole series looks good to go now, thanks for picking it up.

Robin.

> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index eaa8f44..8bb0eea 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1213,7 +1213,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>  			continue;
>  
>  		s2cr[idx].type = type;
> -		s2cr[idx].privcfg = S2CR_PRIVCFG_UNPRIV;
> +		s2cr[idx].privcfg = S2CR_PRIVCFG_DEFAULT;
>  		s2cr[idx].cbndx = cbndx;
>  		arm_smmu_write_s2cr(smmu, idx);
>  	}
> 
