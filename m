From: daniel@zonque.org (Daniel Mack)
Date: Sun, 24 Jun 2018 19:41:34 +0200
Subject: [PATCH] arm: dts: pxa3xx: Add ssp ports to pxa3xx device tree
Message-ID: <20180624174134.20581-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also fix the documentation for these bindings.

The DMA properties have to be passed in the ssp users for now.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/sound/mrvl,pxa-ssp.txt           |  8 ++---
 arch/arm/boot/dts/pxa3xx.dtsi                 | 32 +++++++++++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
index 74c9ba6c2823..efd3fb1f68d2 100644
--- a/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
+++ b/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
@@ -9,20 +9,18 @@ Example:
 
 	/* upstream device */
 
-	ssp0: ssp at 41000000 {
+	ssp1: ssp at 41000000 {
 		compatible = "mrvl,pxa3xx-ssp";
 		reg = <0x41000000 0x40>;
 		interrupts = <24>;
 		clock-names = "pxa27x-ssp.0";
-		dmas = <&dma 13
-			&dma 14>;
-		dma-names = "rx", "tx";
 	};
 
 	/* DAI as user */
 
 	ssp_dai0: ssp_dai at 0 {
 		compatible = "mrvl,pxa-ssp-dai";
-		port = <&ssp0>;
+		port = <&ssp1>;
+		#sound-dai-cells = <0>;
 	};
 
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 132a3b8ab148..3851057bc77d 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -242,6 +242,38 @@
 			clocks = <&clks CLK_PWM1>;
 			status = "disabled";
 		};
+
+		ssp1: ssp at 41000000 {
+			compatible = "mrvl,pxa3xx-ssp";
+			reg = <0x41000000 0x40>;
+			interrupts = <24>;
+			clocks = <&clks CLK_SSP1>;
+			status = "disabled";
+		};
+
+		ssp2: ssp at 41700000 {
+			compatible = "mrvl,pxa3xx-ssp";
+			reg = <0x41700000 0x40>;
+			interrupts = <16>;
+			clocks = <&clks CLK_SSP2>;
+			status = "disabled";
+		};
+
+		ssp3: ssp at 41900000 {
+			compatible = "mrvl,pxa3xx-ssp";
+			reg = <0x41900000 0x40>;
+			interrupts = <0>;
+			clocks = <&clks CLK_SSP3>;
+			status = "disabled";
+		};
+
+		ssp4: ssp at 41a00000 {
+			compatible = "mrvl,pxa3xx-ssp";
+			reg = <0x41a00000 0x40>;
+			interrupts = <13>;
+			clocks = <&clks CLK_SSP4>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.17.1
