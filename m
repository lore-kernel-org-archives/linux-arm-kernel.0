From: jan.tuerk@emtrion.com (Jan Tuerk)
Date: Tue, 27 Nov 2018 16:04:04 +0100
Subject: [PATCH v8 4/4] ARM: imx_v6_v7_defconfig: Enable DA9063 PMIC support.
In-Reply-To: <20181127150407.15098-1-jan.tuerk@emtrion.com>
References: <20180829100811.55836-1-jan.tuerk@emtrion.com>
 <20181127150407.15098-1-jan.tuerk@emtrion.com>
Message-ID: <20181127150407.15098-4-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All recent emtrion modules based on i.mx6 make use of the DA9063.
Therefore enable it with the following defaults:
	- CONFIG_MFD_DA9063=y
	- CONFIG_REGULATOR_DA9063=y
	- CONFIG_DA9063_WATCHDOG=m
MFD and REGULATOR are built-in to have it at Kernel boot-time.
The WATCHDOG is optional and could be loaded from userspace.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

Unchanged since v6 (rebased)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1ad5736c8fa6..d3365c0fd4ad 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -225,10 +225,12 @@ CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9062_WATCHDOG=y
+CONFIG_DA9063_WATCHDOG=m
 CONFIG_RN5T618_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
 CONFIG_MFD_DA9062=y
+CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
@@ -238,6 +240,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
+CONFIG_REGULATOR_DA9063=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
-- 
emtrion GmbH
Alter Schlachthof 45
76131 Karlsruhe
GERMANY
https://www.emtrion.de

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
