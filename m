From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 26 Oct 2015 16:09:41 +0800
Subject: [PATCH v2 1/5] dt-binding: spi: Mediatek: Update document devicetree
 bindings to support multiple devices
In-Reply-To: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
References: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1445846985-26229-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates document devicetree bindings
to support multiple devices.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 6160ffb..ce363c923f 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -29,8 +29,11 @@ Required properties:
   muxes clock, and "spi-clk" for the clock gate.
 
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
@@ -49,7 +52,7 @@ spi: spi at 1100a000 {
 		 <&topckgen CLK_TOP_SPI_SEL>,
 		 <&pericfg CLK_PERI_SPI0>;
 	clock-names = "parent-clk", "sel-clk", "spi-clk";
-
-	mediatek,pad-select = <0>;
+	cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
+	mediatek,pad-select = <1>, <0>;
 	status = "disabled";
 };
-- 
1.8.1.1.dirty
