From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:16 +0100
Subject: [PATCH v2 18/23] drivers: Enable building of Kirkwood drivers for
 mach-mvebu
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-19-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the move to mach-mvebu, drivers Kconfig need tweeking to allow
the kirkwood specific drivers to be built.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
v2
Simplify cpufreq/Kconfig.arm
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 drivers/cpuidle/Kconfig.arm | 2 +-
 drivers/leds/Kconfig        | 4 ++--
 drivers/phy/Kconfig         | 2 +-
 drivers/thermal/Kconfig     | 2 +-
 sound/soc/kirkwood/Kconfig  | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 31297499a60a..077db3aa985b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -113,7 +113,7 @@ config ARM_INTEGRATOR
 	  If in doubt, say Y.
 
 config ARM_KIRKWOOD_CPUFREQ
-	def_bool ARCH_KIRKWOOD && OF
+	def_bool MACH_KIRKWOOD
 	help
 	  This adds the CPUFreq driver for Marvell Kirkwood
 	  SoCs.
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index d988948a89a0..97ccc31dbdd8 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -22,7 +22,7 @@ config ARM_HIGHBANK_CPUIDLE
 
 config ARM_KIRKWOOD_CPUIDLE
 	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
-	depends on ARCH_KIRKWOOD
+	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
 	help
 	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
 
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 72156c123033..44c358ecf5a1 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -421,7 +421,7 @@ config LEDS_MC13783
 config LEDS_NS2
 	tristate "LED support for Network Space v2 GPIO LEDs"
 	depends on LEDS_CLASS
-	depends on ARCH_KIRKWOOD
+	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
 	default y
 	help
 	  This option enable support for the dual-GPIO LED found on the
@@ -431,7 +431,7 @@ config LEDS_NS2
 config LEDS_NETXBIG
 	tristate "LED support for Big Network series LEDs"
 	depends on LEDS_CLASS
-	depends on ARCH_KIRKWOOD
+	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
 	default y
 	help
 	  This option enable support for LEDs found on the LaCie 2Big
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index afa2354f6600..5e6b33f9c294 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -24,7 +24,7 @@ config PHY_EXYNOS_MIPI_VIDEO
 
 config PHY_MVEBU_SATA
 	def_bool y
-	depends on ARCH_KIRKWOOD || ARCH_DOVE
+	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_KIRKWOOD
 	depends on OF
 	select GENERIC_PHY
 
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 35c066489a19..1bc9cbc4f1b8 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -142,7 +142,7 @@ config RCAR_THERMAL
 
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
-	depends on ARCH_KIRKWOOD
+	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
 	depends on OF
 	help
 	  Support for the Kirkwood thermal sensor driver into the Linux thermal
diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 78ed4a42ad21..106e2e22fed2 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || COMPILE_TEST
+	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_KIRKWOOD || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
-- 
1.8.5.3
