From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  7 Jun 2017 08:23:03 +0800
Subject: [PATCH 1/3] arm64: allwinner: h5: sort the device nodes in / part for
 some boards
Message-ID: <20170607002305.15897-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reg_vcc3v3 node is wrongly placed at the start of the / part, but
not with other fixed regulators used by the board, which makes the
device nodes unsorted.

As Orange Pi Prime and Nano Pi NEO2 device trees are copy'n'paste works,
they share the device node unsorted issue.

Fix this by move reg_vcc3v3 node to the position before reg_usb0_vbus.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts    | 14 +++++++-------
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index f6d71b0d482a..f2767b99c28a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -49,13 +49,6 @@
 	model = "FriendlyARM NanoPi NEO 2";
 	compatible = "friendlyarm,nanopi-neo2", "allwinner,sun50i-h5";
 
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	aliases {
 		serial0 = &uart0;
 	};
@@ -79,6 +72,13 @@
 		};
 	};
 
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_usb0_vbus: usb0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb0-vbus";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index 28d92a612329..097c33386190 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -53,13 +53,6 @@
 	model = "Xunlong Orange Pi Prime";
 	compatible = "xunlong,orangepi-prime", "allwinner,sun50i-h5";
 
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	aliases {
 		serial0 = &uart0;
 	};
@@ -93,6 +86,13 @@
 		};
 	};
 
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_usb0_vbus: usb0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb0-vbus";
-- 
2.12.2
