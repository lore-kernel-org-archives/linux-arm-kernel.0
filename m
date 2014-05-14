From: stefan@agner.ch (stefan at agner.ch)
Date: Wed, 14 May 2014 23:31:50 +0200
Subject: [PATCH] ARM: add drivers for Colibri T30 to multi_v7_defconfig
Message-ID: <1400103110-17574-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

Toradex Colibri Evaluation Board uses the DS1307 RTC and the
MCP251x CAN controller. The NVIDIA Tegra 3 based Colibri T30
module can be used on this carrier board, hence enable those
drivers in tegra_defonfig and multi_v7_defconfig.

Furthermore the NVIDIA Tegra 3 based Apalis T30 module too
contains two MCP251x CAN controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47..20d9f11 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -96,6 +96,11 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_CAN=y
+CONFIG_CAN_RAW=y
+CONFIG_CAN_BCM=y
+CONFIG_CAN_DEV=y
+CONFIG_CAN_MCP251X=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=y
@@ -286,6 +291,7 @@ CONFIG_EDAC_HIGHBANK_MC=y
 CONFIG_EDAC_HIGHBANK_L2=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AS3722=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_TWL4030=y
-- 
1.9.2
