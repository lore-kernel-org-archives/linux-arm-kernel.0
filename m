From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed,  5 Oct 2016 11:48:24 +0200
Subject: [PATCH] ARM: dt: sun8i-h3: Add sunxi-sid to dts for sun8i-h3
Message-ID: <1475660904-7959-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the sunxi-sid driver to the device tree for sun8i-h3.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 9f58bb4..abfd29c 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -211,6 +211,11 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom at 01c14200 {
+			compatible = "allwinner,sun7i-a20-sid";
+			reg = <0x01c14200 0x200>;
+		};
+
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun8i-h3-usb-phy";
 			reg = <0x01c19400 0x2c>,
-- 
2.7.3
