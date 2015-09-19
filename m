From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 19 Sep 2015 13:25:54 +0200
Subject: [PATCH] ARM: BCM5301X: Netgear R6250 add USB GPIO
Message-ID: <1442661954-27951-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPIO number which is needed to activate the USB power supply.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 64b8d10..ca92bba 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -24,6 +24,17 @@
 		reg = <0x00000000 0x08000000>;
 	};
 
+	axi at 18000000 {
+		usb3 at 23000 {
+			reg = <0x00023000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-- 
2.1.4
