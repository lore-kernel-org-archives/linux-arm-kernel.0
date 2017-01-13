From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 13 Jan 2017 15:35:38 +0800
Subject: [PATCH v3 2/3] Documentation: devicetree: Add document bindings for
 mtk-cir
In-Reply-To: <1484292939-9454-1-git-send-email-sean.wang@mediatek.com>
References: <1484292939-9454-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1484292939-9454-3-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patch adds documentation for devicetree bindings for
consumer Mediatek IR controller.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/media/mtk-cir.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mtk-cir.txt

diff --git a/Documentation/devicetree/bindings/media/mtk-cir.txt b/Documentation/devicetree/bindings/media/mtk-cir.txt
new file mode 100644
index 0000000..2be2005
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mtk-cir.txt
@@ -0,0 +1,24 @@
+Device-Tree bindings for Mediatek consumer IR controller
+found in Mediatek SoC family
+
+Required properties:
+- compatible	    : "mediatek,mt7623-cir"
+- clocks	    : list of clock specifiers, corresponding to
+		      entries in clock-names property;
+- clock-names	    : should contain "clk" entries;
+- interrupts	    : should contain IR IRQ number;
+- reg		    : should contain IO map address for IR.
+
+Optional properties:
+- linux,rc-map-name : see rc.txt file in the same directory.
+
+Example:
+
+cir: cir at 10013000 {
+	compatible = "mediatek,mt7623-cir";
+	reg = <0 0x10013000 0 0x1000>;
+	interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&infracfg CLK_INFRA_IRRX>;
+	clock-names = "clk";
+	linux,rc-map-name = "rc-rc6-mce";
+};
-- 
1.9.1
