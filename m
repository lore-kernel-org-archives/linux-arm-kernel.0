From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 16:46:16 +0100
Subject: Applied "regulator: arizona: Split KConfig options for LDO1 and
 MICSUPP regulators" to the regulator tree
In-Reply-To: <1492512234-19210-3-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <E1d32fQ-0001z8-Qj@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: arizona: Split KConfig options for LDO1 and MICSUPP regulators

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7e6425968bf742b9772aa5bae1250158c9312e31 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 18 Apr 2017 11:43:48 +0100
Subject: [PATCH] regulator: arizona: Split KConfig options for LDO1 and
 MICSUPP regulators

The CS47L24 Arizona codec and most Madera codecs do not have a LDO1
regulator. Split the LDO1 and MICSUPP regulators into separate KConfig
options so the LDO1 is only built into the kernel if needed.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig  | 14 +++++++++++---
 drivers/regulator/Makefile |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index be06eb29c681..c026b09c479c 100644
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
index ef7725e2592a..313a7ca97b4d 100644
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
2.11.0
