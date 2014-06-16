From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:29 -0300
Subject: [PATCH 04/10] ARM: sun7i: Add node to represent the DMA controller
In-Reply-To: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1402890635-12342-5-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 SoC has a sun4i-compatible DMA controller. Let's add a node to
represent it on the device tree.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 32efc10..c72fad4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -409,6 +409,14 @@
 			interrupts = <0 0 4>;
 		};
 
+	        dma: dma-controller at 01c02000 {
+	                compatible = "allwinner,sun4i-a10-dma";
+	                reg = <0x01c02000 0x1000>;
+	                interrupts = <0 27 4>;
+	                clocks = <&ahb_gates 6>;
+			#dma-cells = <2>;
+	        };
+
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
-- 
2.0.0
