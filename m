From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  6 Jul 2014 01:05:11 -0300
Subject: [PATCH v2 4/8] ARM: sun5i: Add nodes to represent the DMA controllers
In-Reply-To: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1404619518-7592-5-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10S and A13 SoCs have sun4i-compatible DMA controllers. Let's add
the corresponding nodes to represent them on the device tree.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Note that I have only tested on A10S, if anyone with an A13 device could
test as well, that would be great!

 arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index b64f705..3708817 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -300,6 +300,14 @@
 		#size-cells = <1>;
 		ranges;
 
+	        dma: dma-controller at 01c02000 {
+	                compatible = "allwinner,sun4i-a10-dma";
+	                reg = <0x01c02000 0x1000>;
+	                interrupts = <27>;
+	                clocks = <&ahb_gates 6>;
+			#dma-cells = <2>;
+	        };
+
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 3b2a94c..1f1adf2 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -298,6 +298,14 @@
 		#size-cells = <1>;
 		ranges;
 
+	        dma: dma-controller at 01c02000 {
+	                compatible = "allwinner,sun4i-a10-dma";
+	                reg = <0x01c02000 0x1000>;
+	                interrupts = <27>;
+	                clocks = <&ahb_gates 6>;
+			#dma-cells = <2>;
+	        };
+
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
-- 
2.0.1
