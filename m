From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:34:37 -0600
Subject: [PATCH] pinctrl: tegra: expose config options for individual SoCs
Message-ID: <1374014077-22536-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
This will reduce the number of configurations that need to be supported
by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.

The Tegra pinctrl driver contains a fairly large amount of SoC-specific
code and data. Introduce explicit config options so that the user can
trim the set of supported SoCs if they wish. Default these to on, since
most people will probably want to enable support for all SoCs. This also
avoids the need to change any defconfig files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/Kconfig | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 5a8ad51..25a56b5 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -207,15 +207,21 @@ config PINCTRL_TEGRA
 	select PINCONF
 
 config PINCTRL_TEGRA20
-	bool
+	bool "NVIDIA Tegra20 pin control driver"
+	depends on ARCH_TEGRA
+	default y
 	select PINCTRL_TEGRA
 
 config PINCTRL_TEGRA30
-	bool
+	bool "NVIDIA Tegra30 pin control driver"
+	depends on ARCH_TEGRA
+	default y
 	select PINCTRL_TEGRA
 
 config PINCTRL_TEGRA114
-	bool
+	bool "NVIDIA Tegra114 pin control driver"
+	depends on ARCH_TEGRA
+	default y
 	select PINCTRL_TEGRA
 
 config PINCTRL_TZ1090
-- 
1.8.1.5
