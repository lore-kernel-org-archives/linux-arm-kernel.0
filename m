From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue,  6 Mar 2012 14:35:12 +0200
Subject: [PATCH 1/5] Revert "mfd/Input/ASoC: twl6040 kconfig fixes"
In-Reply-To: <1331037316-7375-1-git-send-email-peter.ujfalusi@ti.com>
References: <1331037316-7375-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1331037316-7375-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit a0afdbc2665bbad5ebc81a43b820e97f56ea0582.

Reverting changes regarding to twl6040 in MFD tree since the patches will go
via the audio tree.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/input/misc/Kconfig |    2 +-
 drivers/mfd/Kconfig        |   11 ++---------
 sound/soc/codecs/Kconfig   |    3 ++-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9450d4c..6a9ee24 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -368,7 +368,7 @@ config INPUT_TWL4030_VIBRA
 
 config INPUT_TWL6040_VIBRA
 	tristate "Support for TWL6040 Vibrator"
-	depends on TWL6040_CORE
+	select TWL6040_CORE
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables support for TWL6040 Vibrator Driver.
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 14e1efa..880c69a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -267,17 +267,10 @@ config TWL6030_PWM
 	  This is used to control charging LED brightness.
 
 config TWL6040_CORE
-	bool "Support for TWL6040 audio codec"
-	depends on I2C=y && GENERIC_HARDIRQS
+	bool
+	depends on I2C && GENERIC_HARDIRQS
 	select MFD_CORE
-	select REGMAP_I2C
 	default n
-	help
-	  Say yes here if you want support for Texas Instruments TWL6040 audio
-	  codec.
-	  This driver provides common support for accessing the device,
-	  additional drivers must be enabled in order to use the
-	  functionality of the device (audio, vibra).
 
 config MFD_STMPE
 	bool "Support STMicroelectronics STMPE"
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6b4d86a..f1a1197 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,7 +56,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
-	select SND_SOC_TWL6040 if TWL6040_CORE
+	select SND_SOC_TWL6040 if I2C
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
@@ -274,6 +274,7 @@ config SND_SOC_TWL4030
 	tristate
 
 config SND_SOC_TWL6040
+	select TWL6040_CORE
 	tristate
 
 config SND_SOC_UDA134X
-- 
1.7.8.5
