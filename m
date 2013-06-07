From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 07 Jun 2013 18:23:38 +0900
Subject: [PATCH V3 2/3] ARM: EXYNOS: Enable PCIe support for Exynos5440
Message-ID: <000e01ce6360$b1b20fd0$15162f70$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PCIe support for Exynos5440 which has two PCIe controllers.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-exynos/Kconfig |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 42d6ea2..53b3b2d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1395,6 +1395,7 @@ config PCI_HOST_ITE8152
 	select DMABOUNCE
 
 source "drivers/pci/Kconfig"
+source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 6aa228d..ecd1a3d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -81,6 +81,7 @@ config SOC_EXYNOS5440
 	select PINCTRL
 	select PINCTRL_EXYNOS5440
 	select PM_OPP
+	select MIGHT_HAVE_PCI
 	help
 	  Enable EXYNOS5440 SoC support
 
-- 
1.7.10.4
