From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 14 Sep 2016 15:49:04 +0530
Subject: [PATCH v4 0/2] ARM: cleanup PCI specific configs
Message-ID: <1473848346-17905-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series was initially sent to add support for two PCIe
ports in dra7. This included selecting PCI_DOMAINS config
in SOC_DRA7XX.

However from the review, PCI_DOMAINS can instead be selected
from ARCH_MULTIPLATFORM. This is fixed in this series along
with removing PCI_DOMAINS from other configs.

Changes from v3:
*) Added *Acked-by:*
*) Fixed $subject to not have *Fix*

Kishon Vijay Abraham I (2):
  ARM: stop *MIGHT_HAVE_PCI* config from being selected redundantly
  ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM

 arch/arm/Kconfig                 |    1 +
 arch/arm/mach-at91/Kconfig       |    1 -
 arch/arm/mach-axxia/Kconfig      |    2 --
 arch/arm/mach-cns3xxx/Kconfig    |    1 -
 arch/arm/mach-exynos/Kconfig     |    2 --
 arch/arm/mach-imx/Kconfig        |    2 --
 arch/arm/mach-integrator/Kconfig |    1 -
 arch/arm/mach-keystone/Kconfig   |    2 --
 arch/arm/mach-shmobile/Kconfig   |    1 -
 arch/arm/mach-spear/Kconfig      |    1 -
 arch/arm/mach-versatile/Kconfig  |    1 -
 11 files changed, 1 insertion(+), 14 deletions(-)

-- 
1.7.9.5
