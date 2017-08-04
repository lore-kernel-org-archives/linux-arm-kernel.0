From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 4 Aug 2017 19:59:36 +0800
Subject: [PATCH v6 1/2] dt-bindings: arm: Add bindings for Mediatek MT2712 SoC
 Platform
In-Reply-To: <1501847977-4023-1-git-send-email-yt.shen@mediatek.com>
References: <1501847977-4023-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1501847977-4023-2-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds dt-binding documentation for Mediatek MT2712.
Only include very basic items: cpu, gic and uart.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt                    | 4 ++++
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt      | 1 +
 Documentation/devicetree/bindings/serial/mtk-uart.txt                 | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index da7bd13..7aa0e98 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -7,6 +7,7 @@ Required root node property:
 
 compatible: Must contain one of
    "mediatek,mt2701"
+   "mediatek,mt2712"
    "mediatek,mt6580"
    "mediatek,mt6589"
    "mediatek,mt6592"
@@ -25,6 +26,9 @@ Supported boards:
 - Evaluation board for MT2701:
     Required root node properties:
       - compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
+- Evaluation board for MT2712:
+    Required root node properties:
+      - compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
 - Evaluation board for MT6580:
     Required root node properties:
       - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 11cc87a..07bf0b9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -17,6 +17,7 @@ Required properties:
 	"mediatek,mt6582-sysirq", "mediatek,mt6577-sysirq": for MT6582
 	"mediatek,mt6580-sysirq", "mediatek,mt6577-sysirq": for MT6580
 	"mediatek,mt6577-sysirq": for MT6577
+	"mediatek,mt2712-sysirq", "mediatek,mt6577-sysirq": for MT2712
 	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index b6cf384..f73abff 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible should contain:
   * "mediatek,mt2701-uart" for MT2701 compatible UARTS
+  * "mediatek,mt2712-uart" for MT2712 compatible UARTS
   * "mediatek,mt6580-uart" for MT6580 compatible UARTS
   * "mediatek,mt6582-uart" for MT6582 compatible UARTS
   * "mediatek,mt6589-uart" for MT6589 compatible UARTS
-- 
1.9.1
