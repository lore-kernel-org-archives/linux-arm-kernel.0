From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:30 -0300
Subject: [PATCH 05/10] ARM: sun4i: Add node to represent the DMA controller
In-Reply-To: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1402890635-12342-6-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's add a node to represent the A10 DMA controller on the device tree.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 9174724..6e61518 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -339,6 +339,14 @@
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
2.0.0
