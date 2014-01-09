From: denis@eukrea.com (Denis Carikli)
Date: Thu,  9 Jan 2014 18:15:16 +0100
Subject: [PATCHv9][ 3/3] ARM: imx_v6_v7_defconfig: Enable some drivers used on
 the cpuimx35.
In-Reply-To: <1389287716-12802-1-git-send-email-denis@eukrea.com>
References: <1389287716-12802-1-git-send-email-denis@eukrea.com>
Message-ID: <1389287716-12802-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eukrea cpuimx35 has a pcf8563 RTC and a LCD gpio regulator.

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
ChangeLog v8->v9:
- Refreshed the patch against the current imx_v6_v7_defconfig.

ChangeLog v6->v7:
- Shawn Guo's CC was moved up.

ChangeLog v5->v6:
- Removed leds support addition because it has already been added by 
  94425a1 ARM: imx_v6_v7_defconfig: Enable LEDS_GPIO related options
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 00746d5..230bfe6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -167,6 +167,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
@@ -227,6 +228,7 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_RTC_DRV_SNVS=y
-- 
1.7.9.5
