From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 10 Aug 2016 18:03:17 +0530
Subject: [RESEND PATCH v3 0/3] ARM: cleanup PCI specific configs
Message-ID: <1470832400-11929-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series was initially sent to add support for two PCIe
ports in dra7. This included selecting PCI_DOMAINS config
in SOC_DRA7XX.

However from the review, PCI_DOMAINS can instead be selected
from ARCH_MULTIPLATFORM. This is fixed in this series along
with removing PCI_DOMAINS from other configs.

Since this series was initially sent to add support for
two PCIe ports in dra7, it has been tested to see if there
are regressions with 1 PCIe port. Though testing of 2 PCIe ports
is not done while sending this patch series, it has been verified
before in few of the customer boards.

Changes from v2:
*) v2 removed MIGHT_HAVE_PCI from platforms that are not
   ARCH_MULTIPLATFORM. Fixed it in this version

Changes from v1:
*) select PCI_DOMAINS config from ARCH_MULTIPLATFORM
*) Fix *MIGHT_HAVE_PCI* config from being selected redundantly

Kishon Vijay Abraham I (3):
  ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes
  ARM: Fix *MIGHT_HAVE_PCI* config from being selected redundantly
  ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM

 arch/arm/Kconfig                 |    1 +
 arch/arm/boot/dts/dra7.dtsi      |    2 ++
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
 12 files changed, 3 insertions(+), 14 deletions(-)

-- 
1.7.9.5
