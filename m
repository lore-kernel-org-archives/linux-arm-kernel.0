From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon,  4 Aug 2014 17:09:57 -0300
Subject: [PATCH v3 3/8] ARM: sun4i: dt: Add node to represent the DMA
 controller
In-Reply-To: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1407183002-29420-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's add a node to represent the A10 DMA controller on the device tree.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---

Changes from v2:
 * Fix whitespace
 * Collect tag from Chen-Yu

 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index d96e179..5c6791a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -339,6 +339,14 @@
 		#size-cells = <1>;
 		ranges;
 
+		dma: dma-controller at 01c02000 {
+			compatible = "allwinner,sun4i-a10-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <27>;
+			clocks = <&ahb_gates 6>;
+			#dma-cells = <2>;
+		};
+
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
-- 
2.0.4
