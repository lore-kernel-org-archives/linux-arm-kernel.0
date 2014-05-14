From: stefan@agner.ch (stefan at agner.ch)
Date: Wed, 14 May 2014 23:45:56 +0200
Subject: [PATCH v2 1/3] ARM: tegra: enable MCP251x CAN controller and DS1307
 RTC
In-Reply-To: <cover.1400103181.git.stefan@agner.ch>
References: <cover.1400103181.git.stefan@agner.ch>
Message-ID: <4cc13e0aba03a5b2d3e5f4049d252956342b1dad.1400103181.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

Toradex Colibri Evaluation Board uses the DS1307 RTC and the
MCP251x CAN controller. The NVIDIA Tegra 3 based Colibri T30
module can be used on this carrier board, hence enable those
drivers in tegra_defonfig.

Furthermore the NVIDIA Tegra 3 based Apalis T30 module too
contains two MCP251x CAN controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/tegra_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 2926281..6329632 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -73,6 +73,11 @@ CONFIG_INET6_IPCOMP=y
 CONFIG_IPV6_MIP6=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_CAN=y
+CONFIG_CAN_RAW=y
+CONFIG_CAN_BCM=y
+CONFIG_CAN_DEV=y
+CONFIG_CAN_MCP251X=y
 CONFIG_BT=y
 CONFIG_BT_RFCOMM=y
 CONFIG_BT_BNEP=y
@@ -222,6 +227,7 @@ CONFIG_LEDS_TRIGGER_TRANSIENT=y
 CONFIG_LEDS_TRIGGER_CAMERA=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AS3722=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_TPS6586X=y
-- 
1.9.2
