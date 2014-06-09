From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  9 Jun 2014 11:09:44 +0900
Subject: [PATCH] ARM: shmobile: lager: Remove duplicate i2c3 nodes
Message-ID: <1402279784-5587-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to an error when merging df40f256b18300e1 ("ARM: shmobile:
lager: add i2c1, i2c2 pins") a duplicate i2c3 node.

This patch moves the duplicate and moves to old node to
be closer to the other new i2c nodes.

Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 295a60e..850dff8 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -333,22 +333,6 @@
 	status = "okay";
 };
 
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
-	status = "okay";
-
-	vdd_dvfs: regulator at 68 {
-		compatible = "diasemi,da9210";
-		reg = <0x68>;
-
-		regulator-min-microvolt = <1000000>;
-		regulator-max-microvolt = <1000000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-};
-
 &cpu0 {
 	cpu0-supply = <&vdd_dvfs>;
 };
@@ -369,6 +353,18 @@
 	pinctrl-names = "default";
 };
 
-&i2c3	{
-	status = "ok";
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "okay";
+
+	vdd_dvfs: regulator at 68 {
+		compatible = "diasemi,da9210";
+		reg = <0x68>;
+
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
-- 
2.0.0.rc2
