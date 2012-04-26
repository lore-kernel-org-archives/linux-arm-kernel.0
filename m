From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 13:58:32 -0600
Subject: [PATCHv3 3/4] iommu/tegra: smmu: Refrain from accessing to AHB
 registers
In-Reply-To: <1335352072-4001-3-git-send-email-hdoyu@nvidia.com>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
 <1335352072-4001-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <4F99A8E8.7090909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 05:07 AM, Hiroshi DOYU wrote:
> Use "tegra_ahb_enable_smmu()" to inform AHB that SMMU is
> ready, instead of directly aceessing AHB registers.

> @@ -397,11 +384,7 @@ static void smmu_setup_regs(struct smmu_device *smmu)
...
> +	tegra_ahb_enable_smmu();

You need to check for an error there, and make smmu_setup_regs()
propagate any error back to its callers and check it there too.
