From: denis@eukrea.com (Denis Carikli)
Date: Tue, 12 Nov 2013 12:24:19 +0100
Subject: [PATCHv8][ 5/5] ARM: imx_v6_v7_defconfig: Enable some drivers used on
 the cpuimx35.
In-Reply-To: <1384255459-15134-1-git-send-email-denis@eukrea.com>
References: <1384255459-15134-1-git-send-email-denis@eukrea.com>
Message-ID: <1384255459-15134-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eukrea cpuimx35 has a pcf8563 RTC and a LCD gpio regulator.

We enable the respective drivers in order to be able to use theses
  features with this configuration.

We also enabled the i.MX35 DT support because the cpuimx35 has now DT support.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v6->v7:
- Shawn Guo's CC was moved up.

ChangeLog v5->v6:
- Removed leds support addition because it has already been added by 
  94425a1 ARM: imx_v6_v7_defconfig: Enable LEDS_GPIO related options
---
 arch/arm/configs/imx_v6_v7_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c814e0e..53e854a 100644
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
@@ -217,6 +219,7 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_RTC_DRV_SNVS=y
-- 
1.7.9.5
