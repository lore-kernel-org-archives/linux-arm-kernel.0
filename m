From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Mon,  9 Jul 2018 16:19:16 +0200
Subject: [PATCH v5 1/6] dt-bindings: media: rcar-vin: Align Gen2 and Gen3
In-Reply-To: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1531145962-1540-2-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Align description of the Gen2 and Gen3 bindings for parallel input.
This commit prepares for description of optional endpoint properties in ports
subnodes accepting parallel video connections.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index e25ab07..39c4e6a 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -39,9 +39,11 @@ Additionally, an alias named vinX will need to be created to specify
 which video input device this is.
 
 The per-board settings Gen2 platforms:
- - port sub-node describing a single endpoint connected to the vin
-   as described in video-interfaces.txt[1]. Only the first one will
-   be considered as each vin interface has one input port.
+
+- port - sub-node describing a single endpoint connected to the VIN
+  from external SoC pins as described in video-interfaces.txt[1].
+  Only the first one will be considered as each vin interface has one
+  input port.
 
 The per-board settings Gen3 platforms:
 
@@ -52,7 +54,7 @@ from local SoC CSI-2 receivers (port at 1) depending on SoC.
 - renesas,id - ID number of the VIN, VINx in the documentation.
 - ports
     - port at 0 - sub-node describing a single endpoint connected to the VIN
-      from external SoC pins described in video-interfaces.txt[1].
+      from external SoC pins as described in video-interfaces.txt[1].
       Describing more than one endpoint in port at 0 is invalid. Only VIN
       instances that are connected to external pins should have port at 0.
     - port at 1 - sub-nodes describing one or more endpoints connected to
-- 
2.7.4
