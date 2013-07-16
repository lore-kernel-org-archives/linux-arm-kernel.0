From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:19:07 -0600
Subject: [PATCH] memory: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
Message-ID: <1374013147-4775-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
This will reduce the number of configurations that need to be supported
by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/memory/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 29a11db..0ed76f7 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -33,7 +33,7 @@ config MVEBU_DEVBUS
 config TEGRA20_MC
 	bool "Tegra20 Memory Controller(MC) driver"
 	default y
-	depends on ARCH_TEGRA_2x_SOC
+	depends on ARCH_TEGRA
 	help
 	  This driver is for the Memory Controller(MC) module available
 	  in Tegra20 SoCs, mainly for a address translation fault
@@ -43,7 +43,7 @@ config TEGRA20_MC
 config TEGRA30_MC
 	bool "Tegra30 Memory Controller(MC) driver"
 	default y
-	depends on ARCH_TEGRA_3x_SOC
+	depends on ARCH_TEGRA
 	help
 	  This driver is for the Memory Controller(MC) module available
 	  in Tegra30 SoCs, mainly for a address translation fault
-- 
1.8.1.5
