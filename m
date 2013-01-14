From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 Jan 2013 14:57:50 +0000
Subject: [PATCH 1/1] ARM: ux500: Disable Power Supply and Battery Management
 by default
Message-ID: <1358175470-5041-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AB8500 Battery Management collection of drivers are more than a
little bit broken. There is lots of work still on-going in that area
and it's improving day by day; however, it's not ready to be enabled
by default just yet.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 231dca6..426270f 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -66,9 +66,9 @@ CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_TC3589X=y
-CONFIG_POWER_SUPPLY=y
-CONFIG_AB8500_BM=y
-CONFIG_AB8500_BATTERY_THERM_ON_BATCTRL=y
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_AB8500_BM is not set
+# CONFIG_AB8500_BATTERY_THERM_ON_BATCTRL is not set
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_MFD_STMPE=y
-- 
1.7.9.5
