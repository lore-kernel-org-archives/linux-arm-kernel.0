From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 May 2017 11:40:18 +0200
Subject: [PATCH 1/4] dt-bindings: mtk-sysirq: Correct bindings for supported
 SoCs
Message-ID: <20170522094021.7837-1-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SoCs supported up to now rely on the fallback binding of mt6577.
Fix the binding description to reflect this.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../interrupt-controller/mediatek,sysirq.txt       | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index a89c03bb1a81..aff3bb2a704b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -4,18 +4,18 @@ Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
 interrupt.
 
 Required properties:
-- compatible: should be one of:
-	"mediatek,mt8173-sysirq"
-	"mediatek,mt8135-sysirq"
-	"mediatek,mt8127-sysirq"
-	"mediatek,mt6795-sysirq"
-	"mediatek,mt6755-sysirq"
-	"mediatek,mt6592-sysirq"
-	"mediatek,mt6589-sysirq"
-	"mediatek,mt6582-sysirq"
-	"mediatek,mt6580-sysirq"
-	"mediatek,mt6577-sysirq"
-	"mediatek,mt2701-sysirq"
+- compatible: should be
+	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
+	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
+	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
+	"mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
+	"mediatek,mt6755-sysirq", "mediatek,mt6577-sysirq": for MT6755
+	"mediatek,mt6592-sysirq", "mediatek,mt6577-sysirq": for MT6592
+	"mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq": for MT6589
+	"mediatek,mt6582-sysirq", "mediatek,mt6577-sysirq": for MT6582
+	"mediatek,mt6580-sysirq", "mediatek,mt6577-sysirq": for MT6580
+	"mediatek,mt6577-sysirq": for MT6577
+	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
 - interrupt-parent: phandle of irq parent for sysirq. The parent must
-- 
2.12.0
