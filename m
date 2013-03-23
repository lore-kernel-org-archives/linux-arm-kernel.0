From: jg1.han@samsung.com (Jingoo Han)
Date: Sat, 23 Mar 2013 13:08:47 +0900
Subject: [PATCH 5/6] ARM: EXYNOS: Enable PCIe support for Exynos5440
In-Reply-To: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
Message-ID: <00c401ce277c$1e4b91a0$5ae2b4e0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PCIe support for Exynos5440 which has two PCIe controllers.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-exynos/Kconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5e34364..76c0f75 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1442,6 +1442,7 @@ config PCI_HOST_ITE8152
 	select DMABOUNCE
 
 source "drivers/pci/Kconfig"
+source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index ef3b69a..023e178 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -77,6 +77,7 @@ config SOC_EXYNOS5440
 	select AUTO_ZRELADDR
 	select PINCTRL
 	select PINCTRL_EXYNOS5440
+	select MIGHT_HAVE_PCI
 	help
 	  Enable EXYNOS5440 SoC support
 
-- 
1.7.2.5
