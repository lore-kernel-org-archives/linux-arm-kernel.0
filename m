From: denis@eukrea.com (Denis Carikli)
Date: Fri, 18 Oct 2013 18:11:48 +0200
Subject: [PATCHv3][ 3/3] ARM: imx_v6_v7_defconfig: Enable some drivers used on
 the cpuimx35.
In-Reply-To: <1382112708-7424-1-git-send-email-denis@eukrea.com>
References: <1382112708-7424-1-git-send-email-denis@eukrea.com>
Message-ID: <1382112708-7424-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eukrea cpuimx35 has a pcf8563 RTC, an LCD gpio regulator,
  and a gpio led.

We enable the respective drivers in order to be able to use theses
  features with this configuration.

We also enabled the i.MX35 DT support because the cpuimx35 has now DT support.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v3:
- The commits touching imx_v6_v7_defconfig were squashed.
---
 arch/arm/configs/imx_v6_v7_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 5d488c2..d8a52a0 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -28,6 +28,7 @@ CONFIG_MACH_QONG=y
 CONFIG_MACH_ARMADILLO5X0=y
 CONFIG_MACH_KZM_ARM11_01=y
 CONFIG_MACH_IMX31_DT=y
+CONFIG_MACH_IMX35_DT=y
 CONFIG_MACH_PCM043=y
 CONFIG_MACH_MX35_3DS=y
 CONFIG_MACH_VPR200=y
@@ -161,6 +162,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_MEDIA_SUPPORT=y
@@ -204,8 +206,13 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_RTC_DRV_SNVS=y
-- 
1.7.9.5
