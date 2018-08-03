From: peda@axentia.se (Peter Rosin)
Date: Fri,  3 Aug 2018 09:23:06 +0200
Subject: [RESEND PATCH v5 1/3] dt-bindings: display: bridge: lvds-transmitter:
 add ti, ds90c185
In-Reply-To: <20180803072308.14962-1-peda@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
Message-ID: <20180803072308.14962-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Start list of actual chips compatible with "lvds-encoder".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..50220190c203 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,7 +22,13 @@ among others.
 
 Required properties:
 
-- compatible: Must be "lvds-encoder"
+- compatible: Must be one or more of the following
+  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
+  - "lvds-encoder" for a generic LVDS encoder device
+
+  When compatible with the generic version, nodes must list the
+  device-specific version corresponding to the device first
+  followed by the generic version.
 
 Required nodes:
 
-- 
2.11.0
