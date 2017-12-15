From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:31 +1030
Subject: [PATCH v2 07/19] ARM: dts: aspeed: Add flash controller clocks
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-8-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
 arch/arm/boot/dts/aspeed-g5.dtsi | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 2e3666d4fbeb..afac0ca0cb10 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -56,6 +56,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-fmc";
+			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			interrupts = <19>;
 			flash at 0 {
@@ -71,6 +72,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-spi";
+			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			flash at 0 {
 				reg = < 0 >;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 24bb2d16b900..f3689caf6fe2 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -56,6 +56,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-fmc";
+			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			interrupts = <19>;
 			flash at 0 {
@@ -81,6 +82,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-spi";
+			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			flash at 0 {
 				reg = < 0 >;
@@ -100,6 +102,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-spi";
+			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			flash at 0 {
 				reg = < 0 >;
-- 
2.14.1
