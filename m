From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 6 Nov 2014 12:53:10 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select thermal related drivers
Message-ID: <1415285590-14868-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the reading of temperature in userspace via:

cat /sys/class/thermal/thermal_zone0/temp

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6790f1b..7bef517 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -164,6 +164,9 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_STMPE=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_CPU_THERMAL=y
+CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
-- 
1.9.1
