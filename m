From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 22 Nov 2016 23:58:30 +0800
Subject: [PATCH v2 2/3] arm64: dts: sunxi: sort the nodes in
 sun50i-a64-pine64.dts
In-Reply-To: <20161122155831.8724-1-icenowy@aosc.xyz>
References: <20161122155831.8724-1-icenowy@aosc.xyz>
Message-ID: <20161122155831.8724-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this dts file, uart0 node is put before i2c1.

Move the uart0 node to the end to satisfy alphebetical order.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch added into v2.
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 4709590..c32ebc7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -57,12 +57,6 @@
 	};
 };
 
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
@@ -72,3 +66,9 @@
 &i2c1_pins {
 	bias-pull-up;
 };
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
-- 
2.10.2
