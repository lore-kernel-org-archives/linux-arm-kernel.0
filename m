From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 10:50:55 +1000
Subject: [PATCH] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
In-Reply-To: <cover.1461631445.git.horms+renesas@verge.net.au>
References: <cover.1461631445.git.horms+renesas@verge.net.au>
Message-ID: <350a73b4f896e620216d8e9429bbac16d89da8b0.1461631445.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that Gen2 is a misnomer for the R-Car PCIE driver
which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
from the help text and Kconfig symbol.

Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
This appears to be in keeping with other PCIE Kconfig symbols.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/shmobile_defconfig | 2 +-
 arch/arm64/configs/defconfig        | 2 +-
 drivers/pci/host/Kconfig            | 4 ++--
 drivers/pci/host/Makefile           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 28234906a064..f9fb719fb940 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -119,7 +119,7 @@ CONFIG_PCI_MSI=y
 CONFIG_PCI_MVEBU=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCI_RCAR_GEN2=y
-CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_PCIE_RCAR=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b7b714c3958c..64547f453d94 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -24,7 +24,7 @@ CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
 CONFIG_PCI_RCAR_GEN2=y
-CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_PCIE_RCAR=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f70505186820..fb2f696b91e7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -56,7 +56,7 @@ CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_IOV=y
-CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_PCIE_RCAR=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_LAYERSCAPE=y
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7a0780d56d2d..8fb1cf54617d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -69,11 +69,11 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
-config PCI_RCAR_GEN2_PCIE
+config PCIE_RCAR
 	bool "Renesas R-Car PCIe controller"
 	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
 	help
-	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
+	  Say Y here if you want PCIe controller support on R-Car SoCs.
 
 config PCI_HOST_COMMON
 	bool
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index d85b5faf9bbc..d3d8e1b36fb9 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
-obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
+obj-$(CONFIG_PCIE_RCAR) += pcie-rcar.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
-- 
2.7.0.rc3.207.g0ac5344
