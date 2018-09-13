From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:26 -0500
Subject: [PATCH] ARM: dts: realview: Fix SPI controller node names
Message-ID: <20180913181245.25484-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
name enables dtc SPI bus checks.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.
 
 arch/arm/boot/dts/arm-realview-eb.dtsi    | 2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi   | 2 +-
 arch/arm/boot/dts/versatile-ab.dts        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm-realview-eb.dtsi
index a917cf8825ca..0e4c7c4c8c09 100644
--- a/arch/arm/boot/dts/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb.dtsi
@@ -371,7 +371,7 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		ssp: ssp at 1000d000 {
+		ssp: spi at 1000d000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1000d000 0x1000>;
 			clocks = <&sspclk>, <&pclk>;
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index f935b72d3d96..f2a1d25eb6cf 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -380,7 +380,7 @@
 			clock-names = "apb_pclk";
 		};
 
-		pb1176_ssp: ssp at 1010b000 {
+		pb1176_ssp: spi at 1010b000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1010b000 0x1000>;
 			interrupt-parent = <&intc_dc1176>;
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 36203288de42..7f9cbdf33a51 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -523,7 +523,7 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		ssp at 1000d000 {
+		spi at 1000d000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1000d000 0x1000>;
 			interrupt-parent = <&intc_pb11mp>;
diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
index 10868ba3277f..a5676697ff3b 100644
--- a/arch/arm/boot/dts/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
@@ -362,7 +362,7 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		ssp: ssp at 1000d000 {
+		ssp: spi at 1000d000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1000d000 0x1000>;
 			clocks = <&sspclk>, <&pclk>;
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 5f61d3609027..6f4f60ba5429 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -373,7 +373,7 @@
 			clock-names = "apb_pclk";
 		};
 
-		ssp at 101f4000 {
+		spi at 101f4000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x101f4000 0x1000>;
 			interrupts = <11>;
-- 
2.17.1
