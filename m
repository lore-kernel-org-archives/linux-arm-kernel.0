From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  1 Sep 2017 11:40:37 +0200
Subject: [PATCH 1/2] drm: bridge: Add bindings for TI THS8134
Message-ID: <20170901094038.4312-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the Texas Instruments
THS8134A and THS8134B VGA DACs by extending and renaming the
existing bindings for THS8135.

These DACs are used for the VGA outputs on the ARM reference
designs such as Integrator, Versatile and RealView.

Cc: devicetree at vger.kernel.org
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../display/bridge/{ti,ths8135.txt => ti,ths813x.txt}        | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/display/bridge/{ti,ths8135.txt => ti,ths813x.txt} (73%)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
similarity index 73%
rename from Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
rename to Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
index 6ec1a880ac18..608435f04796 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
@@ -1,11 +1,15 @@
-THS8135 Video DAC
------------------
+THS8134 and THS8135 Video DAC
+-----------------------------
 
-This is the binding for Texas Instruments THS8135 Video DAC bridge.
+This is the binding for Texas Instruments THS8134A, THS8134B and THS8135
+Video DAC bridge.
 
 Required properties:
 
-- compatible: Must be "ti,ths8135"
+- compatible: Must be one of
+  "ti,ths8134a"
+  "ti,ths8134b"
+  "ti,ths8135"
 
 Required nodes:
 
-- 
2.13.5
