From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jan 2018 15:12:23 +0100
Subject: [PATCH 1/4 v6] drm/bridge: Add bindings for TI THS8134
Message-ID: <20180110141226.27826-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the Texas Instruments
THS8134, THS8134A and THS8134B VGA DACs by extending and
renaming the existing bindings for THS8135.

These DACs are used for the VGA outputs on the ARM reference
designs such as Integrator, Versatile and RealView.

Cc: devicetree at vger.kernel.org
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Fix the more-to-less specific compatible strings.
- Fix some speling.
- Collect Laurent's review tag.
ChangeLog v2->v5:
- Dropped the "ti,ths813x" as it turns out we need precise info
  about the sub-variant anyways as they all very in timings.
- Refine the THS8134 variants, it turns out ths8134, ths8134a
  and ths8134b are three different variants of ths8134.
ChangeLog v1->v2:
- Introduce specific-to-general compatible string:
  compatible = "ti,ths8134a", "ti,ths813x";
  so drivers can handle the whole family the same way.
- Collected Rob's ACK.
---
 .../display/bridge/{ti,ths8135.txt => ti,ths813x.txt}       | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/display/bridge/{ti,ths8135.txt => ti,ths813x.txt} (69%)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
similarity index 69%
rename from Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
rename to Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
index 6ec1a880ac18..df3d7c1ac09e 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
@@ -1,11 +1,16 @@
-THS8135 Video DAC
------------------
+THS8134 and THS8135 Video DAC
+-----------------------------
 
-This is the binding for Texas Instruments THS8135 Video DAC bridge.
+This is the binding for Texas Instruments THS8134, THS8134A, THS8134B and
+THS8135 Video DAC bridges.
 
 Required properties:
 
-- compatible: Must be "ti,ths8135"
+- compatible: Must be one of
+  "ti,ths8134"
+  "ti,ths8134a," "ti,ths8134"
+  "ti,ths8134b", "ti,ths8134"
+  "ti,ths8135"
 
 Required nodes:
 
-- 
2.14.3
