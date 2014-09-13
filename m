From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Sep 2014 21:53:01 +0800
Subject: [PATCH 3/3] ARM: dts: sun8i: Add DMA controller node
In-Reply-To: <1410616381-30226-1-git-send-email-wens@csie.org>
References: <1410616381-30226-1-git-send-email-wens@csie.org>
Message-ID: <1410616381-30226-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DMA controller node and DMA bindings to the supported devices.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index cc8c650..46a8cc9 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -203,6 +203,15 @@
 		#size-cells = <1>;
 		ranges;
 
+		dma: dma-controller at 01c02000 {
+			compatible = "allwinner,sun8i-a23-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <0 50 4>;
+			clocks = <&ahb1_gates 6>;
+			resets = <&ahb1_rst 6>;
+			#dma-cells = <1>;
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -332,6 +341,8 @@
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 16>;
 			resets = <&apb2_rst 16>;
+			dmas = <&dma 6>, <&dma 6>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -343,6 +354,8 @@
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 17>;
 			resets = <&apb2_rst 17>;
+			dmas = <&dma 7>, <&dma 7>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -354,6 +367,8 @@
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 18>;
 			resets = <&apb2_rst 18>;
+			dmas = <&dma 8>, <&dma 8>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -365,6 +380,8 @@
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 19>;
 			resets = <&apb2_rst 19>;
+			dmas = <&dma 9>, <&dma 9>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -376,6 +393,8 @@
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 20>;
 			resets = <&apb2_rst 20>;
+			dmas = <&dma 10>, <&dma 10>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.1.0
