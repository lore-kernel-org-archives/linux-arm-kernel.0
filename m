From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 17:14:30 +0800
Subject: [PATCH v4 1/4] Document: DT: Add bindings for mediatek MT8173 SoC
 Platform
In-Reply-To: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
References: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1421054073-43468-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 is a 64-bit four core Soc.
And mt8173-evb is a evaluation board based on mt8173.
This commit add the devicetree binding document for
  mediatek MT8173 SoC
  MT8173 sysirq
  MT8173 uart

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt                 | 4 ++++
 Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt | 1 +
 Documentation/devicetree/bindings/serial/mtk-uart.txt              | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 3be4013..dd7550a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -9,6 +9,7 @@ compatible: Must contain one of
    "mediatek,mt6592"
    "mediatek,mt8127"
    "mediatek,mt8135"
+   "mediatek,mt8173"
 
 
 Supported boards:
@@ -25,3 +26,6 @@ Supported boards:
 - MTK mt8135 tablet EVB:
     Required root node properties:
       - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
+- MTK mt8173 tablet EVB:
+    Required root node properties:
+      - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
index d680b07..8794f8d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
@@ -5,6 +5,7 @@ interrupt.
 
 Required properties:
 - compatible: should be one of:
+	"mediatek,mt8173-sysirq"
 	"mediatek,mt8135-sysirq"
 	"mediatek,mt8127-sysirq"
 	"mediatek,mt6589-sysirq"
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 48358a3..0e41b6e 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -2,9 +2,11 @@
 
 Required properties:
 - compatible should contain:
+  * "mediatek,mt8173-uart" for MT8173 compatible UARTS
   * "mediatek,mt6589-uart" for MT6589 compatible UARTS
   * "mediatek,mt6582-uart" for MT6582 compatible UARTS
-  * "mediatek,mt6577-uart" for all compatible UARTS (MT6589, MT6582, MT6577)
+  * "mediatek,mt6577-uart" for all compatible UARTS (MT8173, MT6589, MT6582, 
+	MT6577)
 
 - reg: The base address of the UART register bank.
 
-- 
1.8.1.1.dirty
