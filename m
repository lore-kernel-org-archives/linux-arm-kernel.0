From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Sep 2014 20:12:05 -0700
Subject: [PATCH 11/12] ARM: omap2plus_defconfig: Enable battery and reset
 drivers
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Message-ID: <1410837126-31553-11-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since many omaps run on battery, we should have the battery
drivers enabled. Let's also enable the reset driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 8e6c363..113f104 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -181,6 +181,13 @@ CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_W1=y
+CONFIG_BATTERY_BQ27x00=m
+CONFIG_CHARGER_ISP1704=m
+CONFIG_CHARGER_TWL4030=m
+CONFIG_CHARGER_BQ2415X=m
+CONFIG_CHARGER_BQ24190=m
+CONFIG_CHARGER_BQ24735=m
+CONFIG_POWER_RESET=y
 CONFIG_POWER_AVS=y
 CONFIG_SENSORS_LM75=m
 CONFIG_THERMAL=y
-- 
2.1.0
