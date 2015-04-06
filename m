From: public_timo.s@silentcreek.de (public_timo.s at silentcreek.de)
Date: Mon,  6 Apr 2015 22:57:22 +0200
Subject: [PATCH] ARM: Remove deprecated symbol from defconfig files
Message-ID: <1428353842-3488-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Timo Sigurdsson <public_timo.s@silentcreek.de>

Commit b2b3a8b934e6 ("power/reset: Remove sun6i reboot driver") removed
the sun6i reboot driver. But sunxi_defconfig and multi_v7_defconfig
still contain the symbol CONFIG_POWER_RESET_SUN6I that was deprecated
by that commit, so remove it.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/sunxi_defconfig    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 06075b6..258fda2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -309,7 +309,6 @@ CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_KEYSTONE=y
-CONFIG_POWER_RESET_SUN6I=y
 CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 8f6a570..8f10015 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -77,7 +77,6 @@ CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_SUN6I=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
-- 
2.1.0
