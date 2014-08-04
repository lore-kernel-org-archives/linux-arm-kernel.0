From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon,  4 Aug 2014 17:09:59 -0300
Subject: [PATCH v3 5/8] ARM: sun7i: dt: Add node to represent the DMA
 controller
In-Reply-To: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1407183002-29420-6-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 SoC has a sun4i-compatible DMA controller. Let's add a node to
represent it on the device tree.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---

Changes from v2:
 * Fix whitespace
 * Collect tag from Chen-Yu

 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 01e9466..510b5a8 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -423,6 +423,14 @@
 			interrupts = <0 0 4>;
 		};
 
+		dma: dma-controller at 01c02000 {
+			compatible = "allwinner,sun4i-a10-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <0 27 4>;
+			clocks = <&ahb_gates 6>;
+			#dma-cells = <2>;
+		};
+
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
-- 
2.0.4
