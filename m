From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 11 Feb 2013 18:30:34 +0100
Subject: [PATCH 1/1] memory: tegra_ahb_enable_smmu() depends on
 TEGRA_IOMMU_SMMU
In-Reply-To: <20130206.211635.744922728615926717.hdoyu@nvidia.com>
References: <1360175666-8377-1-git-send-email-hdoyu@nvidia.com><5112A642.1020800@wwwdotorg.org><20130206.211635.744922728615926717.hdoyu@nvidia.com>
Message-ID: <20130211.193034.1346903263789032239.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hiroshi Doyu <hdoyu@nvidia.com> wrote @ Wed, 06 Feb 2013 21:16:35 +0200 (EET):

> Hi Russell,
> 
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 6 Feb 2013 19:51:46 +0100:
> 
> > On 02/06/2013 11:34 AM, Hiroshi Doyu wrote:
> > > New SoC, Tegra114 also uses SMMU. Change tegra_ahb_enable_smmu()'s
> > > dependency from ARCH_TEGRA_3x_SOC to TEGRA_IOMMU_SMMU. No need to edit
> > > whenever a new Tegra SoC comes.
> > > 
> > > The following combination caused build error, which this patch fixes.
> > > 
> > > CONFIG_ARCH_TEGRA_2x_SOC=y
> > > \# CONFIG_ARCH_TEGRA_3x_SOC is not set
> > > CONFIG_ARCH_TEGRA_114_SOC=y
> > > 
> > > drivers/iommu/tegra-smmu.c:485: undefined reference to 'tegra_ahb_enable_smmu'
> > 
> > Tested-by: Stephen Warren <swarren@nvidia.com>
> > 
> > Russell, I assume Hiroshi should upload this to your patch tracker? It's
> > needed for 3.9.
> 
> FYI: Submitted as:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7640/1

Russell,

Is the above ok for you?
Please let me know if still I need to do something.
