From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 14:18:34 -0600
Subject: [PATCH v2 15/22] iommu/tegra: smmu: Calculate ASID register offset
 by ID
In-Reply-To: <1373021097-32420-16-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-16-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E84D9A.2080507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Calculate ASID register offset by ID so that we can get rid of SoC
> specific MACROs. This is needed for the unified SMMU driver over Tegra
> SoCs.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> -#define HWGRP_ASID_REG(x) (smmu_hwgrp_asid_reg[x])
> +#define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)

I think this removes the last use of smmu_hwgrp_asid_reg[]. Don't you
want to delete that in this patch?
