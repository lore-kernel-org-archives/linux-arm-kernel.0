From: erin.lo@mediatek.com (erin.lo at mediatek.com)
Date: Wed, 23 Sep 2015 16:56:09 +0800
Subject: [PATCH 1/2] Document: DT: Add bindings for mediatek MT2701 SoC
 Platform
In-Reply-To: <1442998570-54031-1-git-send-email-erin.lo@mediatek.com>
References: <1442998570-54031-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1442998570-54031-2-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Erin Lo <erin.lo@mediatek.com>

This adds a DT binding documentation for the MT2701 SoC from Mediatek.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt                 | 4 ++++
 Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt | 1 +
 Documentation/devicetree/bindings/serial/mtk-uart.txt              | 5 +++--
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt     | 5 +++--
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt             | 6 +++++-
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 618a919..54f43bc 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -6,6 +6,7 @@ following property:
 Required root node property:
 
 compatible: Must contain one of
+   "mediatek,mt2701"
    "mediatek,mt6580"
    "mediatek,mt6589"
    "mediatek,mt6592"
@@ -17,6 +18,9 @@ compatible: Must contain one of
 
 Supported boards:
 
+- Evaluation board for MT2701:
+    Required root node properties:
+      - compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
 - Evaluation board for MT6580:
     Required root node properties:
       - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
index afef6a8..de969ea 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
@@ -14,6 +14,7 @@ Required properties:
 	"mediatek,mt6582-sysirq"
 	"mediatek,mt6580-sysirq"
 	"mediatek,mt6577-sysirq"
+        "mediatek,mt2701-sysirq"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in
   Documentation/devicetree/bindings/arm/gic.txt
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 2d47add..f5effb7 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -9,8 +9,9 @@ Required properties:
   * "mediatek,mt6589-uart" for MT6589 compatible UARTS
   * "mediatek,mt6582-uart" for MT6582 compatible UARTS
   * "mediatek,mt6580-uart" for MT6580 compatible UARTS
-  * "mediatek,mt6577-uart" for all compatible UARTS (MT8173, MT6795,
-        MT6589, MT6582, MT6580, MT6577)
+  * "mediatek,mt6577-uart" for all compatible UARTS (MT8173, MT6589, MT6582,
+	MT6580, MT6577, MT2701)
+  * "mediatek,mt2701-uart" for MT2701 compatible UARTS
 
 - reg: The base address of the UART register bank.
 
diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 53a3029..e47979f 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -3,10 +3,11 @@ Mediatek MT6577, MT6572 and MT6589 Timers
 
 Required properties:
 - compatible should contain:
+	* "mediatek,mt6589-timer" for MT2701 compatible timers
 	* "mediatek,mt6589-timer" for MT6589 compatible timers
 	* "mediatek,mt6580-timer" for MT6580 compatible timers
-	* "mediatek,mt6577-timer" for all compatible timers (MT6589, MT6580,
-		MT6577)
+	* "mediatek,mt6577-timer" for all compatible timers (MT2701, MT6589,
+		MT6580, MT6577)
 - reg: Should contain location and length for timers register.
 - clocks: Clocks driving the timer hardware. This list should include two
 	clocks. The order is system clock and as second clock the RTC clock.
diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index af9eb5b..6a00939 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -2,7 +2,11 @@ Mediatek SoCs Watchdog timer
 
 Required properties:
 
-- compatible : should be "mediatek,mt6589-wdt"
+- compatible should contain:
+	* "mediatek,mt2701-wdt" for MT2701 compatible watchdog timers
+	* "mediatek,mt6589-wdt" for all compatible watchdog timers (MT2701,
+		MT6589)
+
 - reg : Specifies base physical address and size of the registers.
 
 Example:
-- 
1.8.1.1.dirty
