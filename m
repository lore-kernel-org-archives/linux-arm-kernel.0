From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 1 Aug 2016 16:42:27 +0530
Subject: [PATCH v2 0/3] ARM: cleanup PCI specific configs
Message-ID: <1470049950-4697-1-git-send-email-kishon@ti.com>
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

The 2nd and 3rd patch has been marked as RFT since it modifies
the configs of other platforms I can't test though this
series shouldn't break anything.

Kishon Vijay Abraham I (3):
  ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes
  ARM: Fix *MIGHT_HAVE_PCI* config from being selected redundantly
  ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM

 arch/arm/Kconfig                 |    3 +--
 arch/arm/boot/dts/dra7.dtsi      |    2 ++
 arch/arm/mach-at91/Kconfig       |    1 -
 arch/arm/mach-axxia/Kconfig      |    2 --
 arch/arm/mach-cns3xxx/Kconfig    |    1 -
 arch/arm/mach-exynos/Kconfig     |    2 --
 arch/arm/mach-imx/Kconfig        |    2 --
 arch/arm/mach-integrator/Kconfig |    1 -
 arch/arm/mach-keystone/Kconfig   |    2 --
 arch/arm/mach-ks8695/Kconfig     |    5 -----
 arch/arm/mach-pxa/Kconfig        |    1 -
 arch/arm/mach-shmobile/Kconfig   |    1 -
 arch/arm/mach-spear/Kconfig      |    1 -
 arch/arm/mach-versatile/Kconfig  |    1 -
 14 files changed, 3 insertions(+), 22 deletions(-)

-- 
1.7.9.5
