From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Wed,  3 Jun 2015 11:44:23 +0200
Subject: [PATCH] ARM: at91/dts: kizbox: fix mismatch LED PWM device
Message-ID: <1433324663-20208-1-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The network_red LED uses the 4th PWM device.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index a0e63ff..cf1628f 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -205,7 +205,7 @@
 
 		network_red {
 			label = "pwm:red:network";
-			pwms = <&tcb_pwm 3 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb_pwm 4 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
-- 
1.9.1
