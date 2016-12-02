From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:39 +0000
Subject: [RFC v3 PATCH 21/25] PCI: tegra: limit to MMU build only
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-22-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver rely on MMU for virtual address space optimisations (see
comment around tegra_pcie_bus_alloc()) and breaks NOMMU build, thus
add dependency on MMU.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/pci/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a..836fa02 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -69,7 +69,7 @@ config PCI_IMX6
 
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
-	depends on ARCH_TEGRA && !ARM64
+	depends on ARCH_TEGRA && !ARM64 && MMU
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
-- 
1.7.9.5
