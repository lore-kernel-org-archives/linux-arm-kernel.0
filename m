From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:47:30 -0300
Subject: [PATCH 5/7] ARM: tegra: Make sure efuse is always selected
Message-ID: <1424864850-3466-1-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the introduction of the efuse subsystem, platforms are now required
to select the efuse support explicitly.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 5d1a318..114ea4e 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -11,6 +11,7 @@ menuconfig ARCH_TEGRA
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
+	select EFUSE_TEGRA
 	select USB_ULPI if USB_PHY
 	select USB_ULPI_VIEWPORT if USB_PHY
 	help
-- 
2.3.0
