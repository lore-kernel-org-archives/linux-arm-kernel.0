From: vishnupatekar0510@gmail.com (VishnuPatekar)
Date: Fri, 12 Dec 2014 23:55:48 +0530
Subject: [PATCHv3 5/5] ARM: sunxi: dts: Add note ps2 pins conflict with hdmi
In-Reply-To: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1418408748-9797-6-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Please note that ps20 pins conflict with HDMI on Lime2 Board
so, by deault ps20 and ps21 are disabled for Lime2 Board.
There is no on board ps2 connector and these pins can be used
for different purpose.

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ed364d5..951b615 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -112,7 +112,11 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
-
+
+		/* PS2 0 and PS2 1 are disabled by default; Please note that
+		ps20 pins conflict with HDMI on Lime2 Board
+		*/
+
 		i2c0: i2c at 01c2ac00 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
-- 
1.7.9.5
