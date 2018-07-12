From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 12 Jul 2018 01:50:48 -0400
Subject: [PATCH 3/3] arm: dts: zynq: Add LEDs to the Zybo Z7 board
In-Reply-To: <20180712055049.5098-1-luaraneda@gmail.com>
References: <20180712055049.5098-1-luaraneda@gmail.com>
Message-ID: <20180712055049.5098-4-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an LED node, connected to the Processing System (PS)

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-zybo-z7.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index b68a5e921464..710076c9bc19 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -22,6 +22,15 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		ld4 {
+			label = "zynq-zybo-z7:green:ld4";
+			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	usb_phy0: phy0 {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
-- 
2.18.0
