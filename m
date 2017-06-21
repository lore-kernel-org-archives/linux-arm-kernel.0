From: linux@rempel-privat.de (Oleksij Rempel)
Date: Wed, 21 Jun 2017 19:10:17 +0200
Subject: [PATCH v1] ARM: dts: sun7i: provide ramoops region on BananaPi
Message-ID: <1498065017-30556-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should help provide useful debug information on remote
targets without UART.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index ed2f35a..38923bf 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -63,6 +63,22 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		ramoops at 7fb6a000 {
+			compatible = "ramoops";
+			reg = <0x7fb6a000 0x100000>;
+			ecc-size	= <16>;
+			record-size	= <0x00020000>;
+			console-size	= <0x00020000>;
+			ftrace-size	= <0x00020000>;
+			pmsg-size	= <0x00020000>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-- 
2.7.4
