From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Feb 2013 11:51:46 -0700
Subject: [PATCH 1/1] memory: tegra_ahb_enable_smmu() depends on
 TEGRA_IOMMU_SMMU
In-Reply-To: <1360175666-8377-1-git-send-email-hdoyu@nvidia.com>
References: <1360175666-8377-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <5112A642.1020800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2013 11:34 AM, Hiroshi Doyu wrote:
> New SoC, Tegra114 also uses SMMU. Change tegra_ahb_enable_smmu()'s
> dependency from ARCH_TEGRA_3x_SOC to TEGRA_IOMMU_SMMU. No need to edit
> whenever a new Tegra SoC comes.
> 
> The following combination caused build error, which this patch fixes.
> 
> CONFIG_ARCH_TEGRA_2x_SOC=y
> \# CONFIG_ARCH_TEGRA_3x_SOC is not set
> CONFIG_ARCH_TEGRA_114_SOC=y
> 
> drivers/iommu/tegra-smmu.c:485: undefined reference to 'tegra_ahb_enable_smmu'

Tested-by: Stephen Warren <swarren@nvidia.com>

Russell, I assume Hiroshi should upload this to your patch tracker? It's
needed for 3.9.

Hiroshi, for reference, see:
http://www.arm.linux.org.uk/developer/patches/
