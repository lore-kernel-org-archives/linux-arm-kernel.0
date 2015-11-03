From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 3 Nov 2015 16:59:24 +0100
Subject: [PATCH] ARM: at91/defconfig: remove CONFIG_SSB from Atmel defconfigs
In-Reply-To: <5928552.0ccybX7Zly@wuerfel>
References: <5928552.0ccybX7Zly@wuerfel>
Message-ID: <1446566364-1088-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This "Sonics Silicon Backplane" support is not needed on Atmel SoCs: remove it.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Arnd,

Here is the patch that fixes what you highlighted in your patch "[PATCH] ssb:
mark ssb_bus_register as __maybe_unused". Indeed, there is no reason for
enabling this option.

Thanks for the heads up, bye,
   Nicolas.

 arch/arm/configs/at91_dt_defconfig | 1 -
 arch/arm/configs/sama5_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 1b1e5acd76e2..e4b1be66b3f5 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -125,7 +125,6 @@ CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
-CONFIG_SSB=m
 CONFIG_MFD_ATMEL_HLCDC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index a0c57ac88b27..63f7e6ce649a 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -129,7 +129,6 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
-CONFIG_SSB=m
 CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.1.3
