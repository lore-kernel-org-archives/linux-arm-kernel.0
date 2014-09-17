From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Sep 2014 09:48:16 +0900
Subject: [PATCH v2 5/5] ARM: shmobile: r8a73a4: sort dtsi file by address
In-Reply-To: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
References: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410914896-14395-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[horms+renesas at verge.net.au: updated for removal of dma-multiplexer base
 address]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2 [Simon Horman]
* Rebase
---
 arch/arm/boot/dts/r8a73a4.dtsi | 232 ++++++++++++++++++++---------------------
 1 file changed, 116 insertions(+), 116 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 8a70dcd..c17afef 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -30,18 +30,6 @@
 		};
 	};
 
-	gic: interrupt-controller at f1001000 {
-		compatible = "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0 0xf1001000 0 0x1000>,
-			<0 0xf1002000 0 0x1000>,
-			<0 0xf1004000 0 0x2000>,
-			<0 0xf1006000 0 0x2000>;
-		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -50,6 +38,80 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	dmac: dma-multiplexer {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dma0: dma-controller at e6700020 {
+			compatible = "renesas,shdma-r8a73a4";
+			reg = <0 0xe6700020 0 0x89e0>;
+			interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
+					0 200 IRQ_TYPE_LEVEL_HIGH
+					0 201 IRQ_TYPE_LEVEL_HIGH
+					0 202 IRQ_TYPE_LEVEL_HIGH
+					0 203 IRQ_TYPE_LEVEL_HIGH
+					0 204 IRQ_TYPE_LEVEL_HIGH
+					0 205 IRQ_TYPE_LEVEL_HIGH
+					0 206 IRQ_TYPE_LEVEL_HIGH
+					0 207 IRQ_TYPE_LEVEL_HIGH
+					0 208 IRQ_TYPE_LEVEL_HIGH
+					0 209 IRQ_TYPE_LEVEL_HIGH
+					0 210 IRQ_TYPE_LEVEL_HIGH
+					0 211 IRQ_TYPE_LEVEL_HIGH
+					0 212 IRQ_TYPE_LEVEL_HIGH
+					0 213 IRQ_TYPE_LEVEL_HIGH
+					0 214 IRQ_TYPE_LEVEL_HIGH
+					0 215 IRQ_TYPE_LEVEL_HIGH
+					0 216 IRQ_TYPE_LEVEL_HIGH
+					0 217 IRQ_TYPE_LEVEL_HIGH
+					0 218 IRQ_TYPE_LEVEL_HIGH
+					0 219 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15",
+					"ch16", "ch17", "ch18", "ch19";
+		};
+	};
+
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-r8a73a4";
+		reg = <0 0xe6050000 0 0x9000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupts-extended =
+			<&irqc0  0 0>, <&irqc0  1 0>, <&irqc0  2 0>, <&irqc0  3 0>,
+			<&irqc0  4 0>, <&irqc0  5 0>, <&irqc0  6 0>, <&irqc0  7 0>,
+			<&irqc0  8 0>, <&irqc0  9 0>, <&irqc0 10 0>, <&irqc0 11 0>,
+			<&irqc0 12 0>, <&irqc0 13 0>, <&irqc0 14 0>, <&irqc0 15 0>,
+			<&irqc0 16 0>, <&irqc0 17 0>, <&irqc0 18 0>, <&irqc0 19 0>,
+			<&irqc0 20 0>, <&irqc0 21 0>, <&irqc0 22 0>, <&irqc0 23 0>,
+			<&irqc0 24 0>, <&irqc0 25 0>, <&irqc0 26 0>, <&irqc0 27 0>,
+			<&irqc0 28 0>, <&irqc0 29 0>, <&irqc0 30 0>, <&irqc0 31 0>,
+			<&irqc1  0 0>, <&irqc1  1 0>, <&irqc1  2 0>, <&irqc1  3 0>,
+			<&irqc1  4 0>, <&irqc1  5 0>, <&irqc1  6 0>, <&irqc1  7 0>,
+			<&irqc1  8 0>, <&irqc1  9 0>, <&irqc1 10 0>, <&irqc1 11 0>,
+			<&irqc1 12 0>, <&irqc1 13 0>, <&irqc1 14 0>, <&irqc1 15 0>,
+			<&irqc1 16 0>, <&irqc1 17 0>, <&irqc1 18 0>, <&irqc1 19 0>,
+			<&irqc1 20 0>, <&irqc1 21 0>, <&irqc1 22 0>, <&irqc1 23 0>,
+			<&irqc1 24 0>, <&irqc1 25 0>;
+	};
+
+	i2c5: i2c at e60b0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe60b0000 0 0x428>;
+		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	irqc0: interrupt-controller at e61c0000 {
 		compatible = "renesas,irqc-r8a73a4", "renesas,irqc";
 		#interrupt-cells = <2>;
@@ -122,48 +184,6 @@
 			     <0 57 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	dmac: dma-multiplexer {
-		compatible = "renesas,shdma-mux";
-		#dma-cells = <1>;
-		dma-channels = <20>;
-		dma-requests = <256>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		dma0: dma-controller at e6700020 {
-			compatible = "renesas,shdma-r8a73a4";
-			reg = <0 0xe6700020 0 0x89e0>;
-			interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
-					0 200 IRQ_TYPE_LEVEL_HIGH
-					0 201 IRQ_TYPE_LEVEL_HIGH
-					0 202 IRQ_TYPE_LEVEL_HIGH
-					0 203 IRQ_TYPE_LEVEL_HIGH
-					0 204 IRQ_TYPE_LEVEL_HIGH
-					0 205 IRQ_TYPE_LEVEL_HIGH
-					0 206 IRQ_TYPE_LEVEL_HIGH
-					0 207 IRQ_TYPE_LEVEL_HIGH
-					0 208 IRQ_TYPE_LEVEL_HIGH
-					0 209 IRQ_TYPE_LEVEL_HIGH
-					0 210 IRQ_TYPE_LEVEL_HIGH
-					0 211 IRQ_TYPE_LEVEL_HIGH
-					0 212 IRQ_TYPE_LEVEL_HIGH
-					0 213 IRQ_TYPE_LEVEL_HIGH
-					0 214 IRQ_TYPE_LEVEL_HIGH
-					0 215 IRQ_TYPE_LEVEL_HIGH
-					0 216 IRQ_TYPE_LEVEL_HIGH
-					0 217 IRQ_TYPE_LEVEL_HIGH
-					0 218 IRQ_TYPE_LEVEL_HIGH
-					0 219 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14", "ch15",
-					"ch16", "ch17", "ch18", "ch19";
-		};
-	};
-
 	thermal at e61f0000 {
 		compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
@@ -216,15 +236,6 @@
 		status = "disabled";
 	};
 
-	i2c5: i2c at e60b0000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
-		reg = <0 0xe60b0000 0 0x428>;
-		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
 	i2c6: i2c at e6550000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -252,20 +263,6 @@
 		status = "disabled";
 	};
 
-	scifa0: serial at e6c40000 {
-		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
-		reg = <0 0xe6c40000 0 0x100>;
-		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
-	scifa1: serial at e6c50000 {
-		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
-		reg = <0 0xe6c50000 0 0x100>;
-		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
 	scifb2: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
@@ -280,6 +277,20 @@
 		status = "disabled";
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
+		reg = <0 0xe6c40000 0 0x100>;
+		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
+		reg = <0 0xe6c50000 0 0x100>;
+		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	scifb4: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
@@ -294,45 +305,6 @@
 		status = "disabled";
 	};
 
-	mmcif0: mmc at ee200000 {
-		compatible = "renesas,sh-mmcif";
-		reg = <0 0xee200000 0 0x80>;
-		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
-		reg-io-width = <4>;
-		status = "disabled";
-	};
-
-	mmcif1: mmc at ee220000 {
-		compatible = "renesas,sh-mmcif";
-		reg = <0 0xee220000 0 0x80>;
-		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
-		reg-io-width = <4>;
-		status = "disabled";
-	};
-
-	pfc: pfc at e6050000 {
-		compatible = "renesas,pfc-r8a73a4";
-		reg = <0 0xe6050000 0 0x9000>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupts-extended =
-			<&irqc0  0 0>, <&irqc0  1 0>, <&irqc0  2 0>, <&irqc0  3 0>,
-			<&irqc0  4 0>, <&irqc0  5 0>, <&irqc0  6 0>, <&irqc0  7 0>,
-			<&irqc0  8 0>, <&irqc0  9 0>, <&irqc0 10 0>, <&irqc0 11 0>,
-			<&irqc0 12 0>, <&irqc0 13 0>, <&irqc0 14 0>, <&irqc0 15 0>,
-			<&irqc0 16 0>, <&irqc0 17 0>, <&irqc0 18 0>, <&irqc0 19 0>,
-			<&irqc0 20 0>, <&irqc0 21 0>, <&irqc0 22 0>, <&irqc0 23 0>,
-			<&irqc0 24 0>, <&irqc0 25 0>, <&irqc0 26 0>, <&irqc0 27 0>,
-			<&irqc0 28 0>, <&irqc0 29 0>, <&irqc0 30 0>, <&irqc0 31 0>,
-			<&irqc1  0 0>, <&irqc1  1 0>, <&irqc1  2 0>, <&irqc1  3 0>,
-			<&irqc1  4 0>, <&irqc1  5 0>, <&irqc1  6 0>, <&irqc1  7 0>,
-			<&irqc1  8 0>, <&irqc1  9 0>, <&irqc1 10 0>, <&irqc1 11 0>,
-			<&irqc1 12 0>, <&irqc1 13 0>, <&irqc1 14 0>, <&irqc1 15 0>,
-			<&irqc1 16 0>, <&irqc1 17 0>, <&irqc1 18 0>, <&irqc1 19 0>,
-			<&irqc1 20 0>, <&irqc1 21 0>, <&irqc1 22 0>, <&irqc1 23 0>,
-			<&irqc1 24 0>, <&irqc1 25 0>;
-	};
-
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
@@ -356,4 +328,32 @@
 		cap-sd-highspeed;
 		status = "disabled";
 	};
+
+	mmcif0: mmc at ee200000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	mmcif1: mmc at ee220000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee220000 0 0x80>;
+		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	gic: interrupt-controller at f1001000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0 0xf1001000 0 0x1000>,
+			<0 0xf1002000 0 0x1000>,
+			<0 0xf1004000 0 0x2000>,
+			<0 0xf1006000 0 0x2000>;
+		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
 };
-- 
2.0.1
