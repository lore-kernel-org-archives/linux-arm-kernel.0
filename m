From: raashidmuhammed@zilogic.com (Raashid Muhammed)
Date: Fri, 24 Jun 2016 19:01:09 +0530
Subject: [PATCH 2/2] ARM: dts: at91: Modify information in LED nodes.
In-Reply-To: <1466775069-606-1-git-send-email-raashidmuhammed@zilogic.com>
References: <1466775069-606-1-git-send-email-raashidmuhammed@zilogic.com>
Message-ID: <1466775069-606-2-git-send-email-raashidmuhammed@zilogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power led node and rename status led node.

Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
---
 arch/arm/boot/dts/at91-sam9_l9260.dts | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/at91-sam9_l9260.dts
index be409f2..814753a 100644
--- a/arch/arm/boot/dts/at91-sam9_l9260.dts
+++ b/arch/arm/boot/dts/at91-sam9_l9260.dts
@@ -106,11 +106,16 @@
 	leds {
 		compatible = "gpio-leds";
 
-		b0 {
-			label = "b0";
-			gpios = <&pioA 6 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
+		pwr_led {
+			label = "sam9-l9260:yellow:pwr";
+			gpios = <&pioA 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "cpu0";
 		};
 
+		status_led {
+			label = "sam9-l9260:green:status";
+			gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
 	};
 };
-- 
2.1.4
