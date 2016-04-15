From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 15 Apr 2016 19:30:46 +0900
Subject: [PATCH 1/2] arm64: dts: uniphier: fix I2C nodes of PH1-LD20
In-Reply-To: <1460716247-28049-1-git-send-email-yamada.masahiro@socionext.com>
References: <1460716247-28049-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1460716247-28049-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C hardware blocks on this SoC are connected as follows:

  I2C0: external connection
  I2C1: external connection
  I2C2: internal connection
  I2C3: external connection
  I2C4: external connection
  I2C5: internal connection
  I2C6: no connection (not accessible)

Delete pinctrl from Ch2, add pinctrl to Ch4, and remove the Ch6 node.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../boot/dts/socionext/uniphier-ph1-ld20-ref.dts     |  1 -
 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 20 +++++---------------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts
index 727ae5f..b0ed443 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts
@@ -70,7 +70,6 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		i2c6 = &i2c6;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
index e682a3f..651c9d9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
@@ -201,15 +201,12 @@
 
 		i2c2: i2c at 58782000 {
 			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
 			reg = <0x58782000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <0 43 4>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
+			clock-frequency = <400000>;
 		};
 
 		i2c3: i2c at 58783000 {
@@ -227,12 +224,15 @@
 
 		i2c4: i2c at 58784000 {
 			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
 			reg = <0x58784000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <0 45 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c4>;
 			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
+			clock-frequency = <100000>;
 		};
 
 		i2c5: i2c at 58785000 {
@@ -245,16 +245,6 @@
 			clock-frequency = <400000>;
 		};
 
-		i2c6: i2c at 58786000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58786000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 26 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
-
 		system_bus: system-bus at 58c00000 {
 			compatible = "socionext,uniphier-system-bus";
 			status = "disabled";
-- 
1.9.1
