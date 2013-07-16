From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:17:23 -0600
Subject: [PATCH 4/4] ARM: tegra: move config TEGRA_AHB
In-Reply-To: <1374013043-4693-1-git-send-email-swarren@wwwdotorg.org>
References: <1374013043-4693-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1374013043-4693-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra AHB driver is located in drivers/amba. Move the Kconfig option
that enables it to the Kconfig file in that directory. This completely
decouples it from arch/arm/mach-tegra.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 8 --------
 drivers/Kconfig             | 2 ++
 drivers/amba/Kconfig        | 8 ++++++++
 3 files changed, 10 insertions(+), 8 deletions(-)
 create mode 100644 drivers/amba/Kconfig

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 9a4ec62..94713e4 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -57,14 +57,6 @@ config TEGRA_PCI
 	depends on ARCH_TEGRA
 	select PCI
 
-config TEGRA_AHB
-	bool "Enable AHB driver for NVIDIA Tegra SoCs"
-	default y
-	help
-	  Adds AHB configuration functionality for NVIDIA Tegra SoCs,
-	  which controls AHB bus master arbitration and some
-	  performance parameters(priority, prefech size).
-
 config TEGRA_EMC_SCALING_ENABLE
 	bool "Enable scaling the memory frequency"
 
diff --git a/drivers/Kconfig b/drivers/Kconfig
index aa43b91..5603bc3 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -166,4 +166,6 @@ source "drivers/reset/Kconfig"
 
 source "drivers/fmc/Kconfig"
 
+source "drivers/amba/Kconfig"
+
 endmenu
diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
new file mode 100644
index 0000000..9244e48
--- /dev/null
+++ b/drivers/amba/Kconfig
@@ -0,0 +1,8 @@
+config TEGRA_AHB
+	bool "AHB driver for NVIDIA Tegra SoCs"
+	depends on ARCH_TEGRA
+	default y
+	help
+	  Adds AHB configuration functionality for NVIDIA Tegra SoCs,
+	  which controls AHB bus master arbitration and some
+	  performance parameters (priority, prefetch size).
-- 
1.8.1.5
