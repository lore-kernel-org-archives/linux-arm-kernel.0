From: peda@axentia.se (Peter Rosin)
Date: Mon,  9 Apr 2018 12:59:15 +0200
Subject: [PATCH 2/5] dt-bindings: display: atmel: add optional output-mode
 property
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
Message-ID: <20180409105918.20792-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Useful for beating cases where an output mode selection heuristic
fails.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..dc478455b883 100644
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
@@ -10,6 +10,10 @@ Required properties:
  - #address-cells: should be set to 1.
  - #size-cells: should be set to 0.
 
+Optional properties:
+ - output-mode: override any output mode selection hueristic and force a
+   particular output mode. One of "rgb444", "rgb565", "rgb666" and "rgb888".
+
 Required children nodes:
  Children nodes are encoding available output ports and their connections
  to external devices using the OF graph reprensentation (see ../graph.txt).
-- 
2.11.0
