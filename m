From: rf@opensource.wolfsonmicro.com (Richard Fitzgerald)
Date: Tue, 18 Apr 2017 11:43:48 +0100
Subject: [PATCH 1/7] regulator: arizona: Split KConfig options for LDO1 and
 MICSUPP regulators
In-Reply-To: <1492512234-19210-1-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1492512234-19210-1-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <1492512234-19210-3-git-send-email-rf@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CS47L24 Arizona codec and most Madera codecs do not have a LDO1
regulator. Split the LDO1 and MICSUPP regulators into separate KConfig
options so the LDO1 is only built into the kernel if needed.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/regulator/Kconfig  | 14 +++++++++++---
 drivers/regulator/Makefile |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 290eeb8..8647538 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -125,12 +125,20 @@ config REGULATOR_AB8500
 	  This driver supports the regulators found on the ST-Ericsson mixed
 	  signal AB8500 PMIC
 
-config REGULATOR_ARIZONA
-	tristate "Wolfson Arizona class devices"
+config REGULATOR_ARIZONA_LDO1
+	tristate "Wolfson Arizona class devices LDO1"
 	depends on MFD_ARIZONA
 	depends on SND_SOC
 	help
-	  Support for the regulators found on Wolfson Arizona class
+	  Support for the LDO1 regulators found on Wolfson Arizona class
+	  devices.
+
+config REGULATOR_ARIZONA_MICSUPP
+	tristate "Wolfson Arizona class devices MICSUPP"
+	depends on MFD_ARIZONA
+	depends on SND_SOC
+	help
+	  Support for the MICSUPP regulators found on Wolfson Arizona class
 	  devices.
 
 config REGULATOR_AS3711
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index bf5ed7a..8a439a2 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -19,7 +19,8 @@ obj-$(CONFIG_REGULATOR_ACT8865) += act8865-regulator.o
 obj-$(CONFIG_REGULATOR_ACT8945A) += act8945a-regulator.o
 obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
 obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
-obj-$(CONFIG_REGULATOR_ARIZONA) += arizona-micsupp.o arizona-ldo1.o
+obj-$(CONFIG_REGULATOR_ARIZONA_LDO1) += arizona-ldo1.o
+obj-$(CONFIG_REGULATOR_ARIZONA_MICSUPP) += arizona-micsupp.o
 obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
-- 
1.9.1
