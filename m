From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Apr 2017 16:54:54 +0100
Subject: [PATCH] iommu: arm-smmu: correct sid to mask
In-Reply-To: <1492765416-30835-1-git-send-email-peng.fan@nxp.com>
References: <1492765416-30835-1-git-send-email-peng.fan@nxp.com>
Message-ID: <20170424155453.GP12323@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 05:03:36PM +0800, Peng Fan wrote:
> From code "SMR mask 0x%x out of range for SMMU",
> so, we need to use mask, not sid.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b493c99..5a06de2 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1467,7 +1467,7 @@ static int arm_smmu_add_device(struct device *dev)
>  		}
>  		if (mask & ~smmu->smr_mask_mask) {
>  			dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
> -				sid, smmu->smr_mask_mask);
> +				mask, smmu->smr_mask_mask);
>  			goto out_free;

Looks like a copy-paste error to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Joerg: do you mind picking this one up, please?

Thanks,

Will
