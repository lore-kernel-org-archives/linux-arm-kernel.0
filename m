From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:24 +0900
Subject: [PATCH 15/29] ARM: shmobile: koelsch: Remove duplicate i2c6 nodes
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <897dfdbc14603d764637dea92696fef4fc66ea3e.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A second i2c6 node was a added by
05e234a187058ee ("ARM: shmobile: koelsch dts: Add VDD MPU regulator for
DVFS"). Merge this into the existing node.

Also shuffle i2c nodes so they are all together.

Cc: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index b2e6616..b0cfbd4 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -215,25 +215,6 @@
 	clock-frequency = <20000000>;
 };
 
-&i2c2 {
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-	clock-frequency = <400000>;
-
-	eeprom at 50 {
-		compatible = "renesas,24c02";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-&i2c6 {
-	status = "okay";
-	clock-frequency = <100000>;
-};
-
 &pfc {
 	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
@@ -414,10 +395,25 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom at 50 {
+		compatible = "renesas,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &i2c6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
+	clock-frequency = <100000>;
 
 	vdd_dvfs: regulator at 68 {
 		compatible = "diasemi,da9210";
-- 
2.0.0.rc2
