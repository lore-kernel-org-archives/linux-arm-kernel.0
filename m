From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 14:30:55 -0600
Subject: [PATCH v2 18/22] iommu/tegra: smmu: Use dt-bindings MACRO
In-Reply-To: <1373021097-32420-19-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-19-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E8507F.3050601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Use dt-bindings MACRO instead of SoC dependent MACROs.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> -	if (map & HWG_AVPC) {
> +	if (map & TEGRA_SWGROUP_BIT(AVPC)) {

Patch 17 removes the definition of HWG_AVPC. So, git bisect is broken.
