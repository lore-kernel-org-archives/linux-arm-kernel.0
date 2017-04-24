From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 25 Apr 2017 00:59:46 +0200
Subject: [PATCH] ARM: tegra: Select appropriate DMA options for LPAE
Message-ID: <20170424225946.19425-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This automatically selects options for zone DMA and 64 bit DMA addresses
when LPAE is enabled on ARM Tegra platforms. These options are required
for proper operation with LPAE enabled.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-tegra/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 329f01c5b6f8..c8368d647741 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -13,5 +13,7 @@ menuconfig ARCH_TEGRA
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
+	select ZONE_DMA if ARM_LPAE
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	help
 	  This enables support for NVIDIA Tegra based systems.
-- 
2.12.2
