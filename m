From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 12 Jun 2018 16:26:06 +0200
Subject: [PATCH v4 6/6] dt-bindings: media: rcar-vin: Clarify optional props
In-Reply-To: <1528813566-17927-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1528813566-17927-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1528813566-17927-7-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a note to the R-Car VIN interface bindings to clarify that all
properties listed as generic properties in video-interfaces.txt can
be included in port at 0 endpoint, but if not explicitly listed in the
interface bindings documentation, they do not modify it behaviour.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 8130849..03544c7 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -55,6 +55,12 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
       instances that are connected to external pins should have port 0.
 
       - Optional properties for endpoint nodes of port at 0:
+
+        All properties described in [1] and which apply to the selected
+        media bus type could be optionally listed here to better describe
+        the current hardware configuration, but only the following ones do
+        actually modify the VIN interface behaviour:
+
         - hsync-active: see [1] for description. Default is active high.
         - vsync-active: see [1] for description. Default is active high.
         - data-enable-active: polarity of CLKENB signal, see [1] for
-- 
2.7.4
