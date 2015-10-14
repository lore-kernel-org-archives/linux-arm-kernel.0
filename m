From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 14 Oct 2015 11:23:31 +0800
Subject: [PATCH 1/5] dt-binding: spi: Mediatek: Update document devicetree
 bindings to support multiple devices
In-Reply-To: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
References: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1444793015-30359-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update document devicetree bindings to
support multiple devices.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index dcefc43..8391193 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -28,8 +28,11 @@ Required properties:
   "parent-clk" for the parent clock.
 
 Optional properties:
+-cs-gpios: see spi-bus.txt, only required for MT8173.
+
 - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
-  controller used, this value should be 0~3, only required for MT8173.
+  controller used. This is a array, the element value should be 0~3,
+  only required for MT8173.
     0: specify GPIO69,70,71,72 for spi pins.
     1: specify GPIO102,103,104,105 for spi pins.
     2: specify GPIO128,129,130,131 for spi pins.
@@ -46,6 +49,7 @@ spi: spi at 1100a000 {
 	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
 	clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
 	clock-names = "spi-clk", "parent-clk";
-	mediatek,pad-select = <0>;
+	cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
+	mediatek,pad-select = <1>, <0>;
 	status = "disabled";
 };
-- 
1.8.1.1.dirty
