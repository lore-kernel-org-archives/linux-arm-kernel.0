From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Oct 2017 22:54:23 +0200
Subject: [PATCH 1/5 v2] watchdog: gemini/ftwdt010: rename DT bindings
Message-ID: <20171016205427.4297-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree bindings are in two copies and also should be
consolidated into a single Faraday Technology FTWDT010
binding since we uncovered that this IP part is a standard
IP from Faraday.

Cc: devicetree at vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collect Rob's ACK.
---
 .../bindings/watchdog/cortina,gemini-watchdog.txt       | 17 -----------------
 ...{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} | 11 ++++++++---
 2 files changed, 8 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
 rename Documentation/devicetree/bindings/watchdog/{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} (55%)

diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt b/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
deleted file mode 100644
index bc4b865d178b..000000000000
--- a/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Cortina Systems Gemini SoC Watchdog
-
-Required properties:
-- compatible : must be "cortina,gemini-watchdog"
-- reg : shall contain base register location and length
-- interrupts : shall contain the interrupt for the watchdog
-
-Optional properties:
-- timeout-sec : the default watchdog timeout in seconds.
-
-Example:
-
-watchdog at 41000000 {
-	compatible = "cortina,gemini-watchdog";
-	reg = <0x41000000 0x1000>;
-	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
similarity index 55%
rename from Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
rename to Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
index bc4b865d178b..9ecdb502e605 100644
--- a/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
+++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
@@ -1,7 +1,12 @@
-Cortina Systems Gemini SoC Watchdog
+Faraday Technology FTWDT010 watchdog
+
+This is an IP part from Faraday Technology found in the Gemini
+SoCs and others.
 
 Required properties:
-- compatible : must be "cortina,gemini-watchdog"
+- compatible : must be one of
+  "faraday,ftwdt010"
+  "cortina,gemini-watchdog", "faraday,ftwdt010"
 - reg : shall contain base register location and length
 - interrupts : shall contain the interrupt for the watchdog
 
@@ -11,7 +16,7 @@ Optional properties:
 Example:
 
 watchdog at 41000000 {
-	compatible = "cortina,gemini-watchdog";
+	compatible = "faraday,ftwdt010";
 	reg = <0x41000000 0x1000>;
 	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
2.13.6
