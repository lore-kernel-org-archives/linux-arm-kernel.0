From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 20 Jan 2017 23:21:15 +0100
Subject: [PATCH 15/18] ARM64: dts: meson-gxl: Reorder nodes
In-Reply-To: <20170120222118.21476-1-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
Message-ID: <20170120222118.21476-16-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort nodes referenced by label alphabetically.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index bdf2305a2e25..afa74455e1de 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -120,6 +120,26 @@
 	};
 };
 
+&hiubus {
+	clkc: clock-controller at 0 {
+		compatible = "amlogic,gxl-clkc", "amlogic,gxbb-clkc";
+		#clock-cells = <1>;
+		reg = <0x0 0x0 0x0 0x3db>;
+	};
+};
+
+&i2c_A {
+	clocks = <&clkc CLKID_I2C>;
+};
+
+&i2c_B {
+	clocks = <&clkc CLKID_I2C>;
+};
+
+&i2c_C {
+	clocks = <&clkc CLKID_I2C>;
+};
+
 &periphs {
 	pinctrl_periphs: pinctrl at 4b0 {
 		compatible = "amlogic,meson-gxl-periphs-pinctrl";
@@ -320,26 +340,6 @@
 	};
 };
 
-&hiubus {
-	clkc: clock-controller at 0 {
-		compatible = "amlogic,gxl-clkc", "amlogic,gxbb-clkc";
-		#clock-cells = <1>;
-		reg = <0x0 0x0 0x0 0x3db>;
-	};
-};
-
-&i2c_A {
-	clocks = <&clkc CLKID_I2C>;
-};
-
-&i2c_B {
-	clocks = <&clkc CLKID_I2C>;
-};
-
-&i2c_C {
-	clocks = <&clkc CLKID_I2C>;
-};
-
 &sd_emmc_a {
 	clocks = <&clkc CLKID_SD_EMMC_A>,
 		 <&xtal>,
-- 
2.10.2
