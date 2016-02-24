From: draakje197@gmail.com (Henry Paulissen)
Date: Wed, 24 Feb 2016 09:57:25 +0100
Subject: [PATCH] Add triggers for cubietruck leds
Message-ID: <1456304247-2481-1-git-send-email-henry@nitronetworks.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This (small) patch gives the same led trigger functionality
as the 3.4 sunxi kernel and although mainline doesn't has
to be the same, it helps in identifying and builds upon the
user expectations about what those leds mean.

Signed-off-by: Henry Paulissen <henry@nitronetworks.nl>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8da939a..bea6b0f 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -70,21 +70,29 @@
 		blue {
 			label = "cubietruck:blue:usr";
 			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
 		};
 
 		orange {
 			label = "cubietruck:orange:usr";
 			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "cpu0";
+			default-state = "off";
 		};
 
 		white {
 			label = "cubietruck:white:usr";
 			gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "cpu1";
+			default-state = "off";
 		};
 
 		green {
 			label = "cubietruck:green:usr";
 			gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
 		};
 	};
 
-- 
2.5.0
