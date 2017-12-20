From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Wed, 20 Dec 2017 14:47:05 +0100
Subject: [PATCH v2 5/5] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
In-Reply-To: <20171220134710.64479-1-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171220134710.64479-1-jan.tuerk@emtrion.com>
Message-ID: <20171220134710.64479-6-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

All recent emtrion modules based on i.mx6 make use of the DA0963.
Therefore enable it with the following defaults:
	- CONFIG_MFD_DA9063=y
	- CONFIG_REGULATOR_DA9063=y
	- CONFIG_DA9063_WATCHDOG=m
	- CONFIG_RTC_DRV_DA9063=m
MFD and REGULATOR are built-in to have it at Kernel boot-time.
The WATCHDOG and RTC are optional and could be loaded from userspace.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0d4494922561..09cd8048b0c1 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -215,8 +215,10 @@ CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_DA9063_WATCHDOG=m
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
+CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_STMPE=y
@@ -224,6 +226,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
+CONFIG_REGULATOR_DA9063=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
@@ -349,6 +352,7 @@ CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
+CONFIG_RTC_DRV_DA9063=m
 CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
-- 
emtrion GmbH
Alter Schlachthof 45
76131 Karlsruhe
GERMANY
https://www.emtrion.de

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
