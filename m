From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:13 +0100
Subject: [PATCH v3 01/15] dt-bindings: panel: lvds: Document power-supply
 property
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <97ebf0615821d79e8d7718594fe3a542a743a05f.1512486553.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power-supply property is used by a vast majority of panels, including
panel-simple. Let's document it as a common property

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/panel/panel-common.txt | 6 ++++++
 Documentation/devicetree/bindings/display/panel/panel-lvds.txt   | 1 +
 Documentation/devicetree/bindings/display/panel/simple-panel.txt | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
index ec52c472c845..125ea68052af 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
@@ -78,6 +78,12 @@ used for panels that implement compatible control signals.
   while active. Active high reset signals can be supported by inverting the
   GPIO specifier polarity flag.
 
+Power
+-----
+
+- power-supply: many display panels need an additional power supply in
+  order to be fully powered-up. For such panels, power-supply contains
+  a phandle to the regulator powering the panel.
 
 Backlight
 ---------
diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.txt b/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
index b938269f841e..250850a2150b 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
@@ -32,6 +32,7 @@ Optional properties:
 - label: See panel-common.txt.
 - gpios: See panel-common.txt.
 - backlight: See panel-common.txt.
+- power-supply: See panel-common.txt.
 - data-mirror: If set, reverse the bit order described in the data mappings
   below on all data lanes, transmitting bits for slots 6 to 0 instead of
   0 to 6.
diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
index 1341bbf4aa3d..16d8ff088b7d 100644
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
@@ -1,7 +1,7 @@
 Simple display panel
 
 Required properties:
-- power-supply: regulator to provide the supply voltage
+- power-supply: See panel-common.txt
 
 Optional properties:
 - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
-- 
git-series 0.9.1
