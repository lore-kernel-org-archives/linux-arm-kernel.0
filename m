From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jun 2014 23:27:19 -0700
Subject: [PATCH] ARM: bcm: Fix bcm and multi_v7 defconfigs
Message-ID: <1403850439-8771-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BCM (Kona/capri platform) has regressed in two ways on this release. First,
bcm_defconfig no longer selected the appropriate MMC driver options due to
changes in dependencies. Secondly, the new MFD and regulator drivers were not
enabled on multi_v7_defconfig, so that caused the system to fail probing MMC
there.

Fix by enabling the new options as needed.

Cc: Matt Porter <matt.porter@linaro.org>
Cc: Christian Daudt <bcm@fixthebug.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
---

Christian, Matt,

Since I know that at least Matt is on vacation right now, I'll add this to the
arm-soc fixes branch myself so I can continue booting the capri board here.


-Olof

 arch/arm/configs/bcm_defconfig      |    2 +-
 arch/arm/configs/multi_v7_defconfig |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 9d13dae..4bf7226 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -94,10 +94,10 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_TEST=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9a1e7b0..f70ea21 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -223,12 +223,12 @@ CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_SUN6I=y
 CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
-CONFIG_DOVE_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AS3722=y
+CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_MAX8907=y
@@ -240,6 +240,7 @@ CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_AS3722=y
+CONFIG_REGULATOR_BCM590XX=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
-- 
1.7.10.4
