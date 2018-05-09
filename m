From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 May 2018 20:45:58 +0200
Subject: [PATCH] media: rcar-vin: Drop unnecessary register properties from
 example vin port
Message-ID: <20180509184558.14960-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The example vin port node does not have an address and thus does not
need address-cells or address size-properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index a19517e1c669..2a0c59e97f40 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -107,9 +107,6 @@ Board setup example for Gen2 platforms (vin1 composite video input)
         status = "okay";
 
         port {
-                #address-cells = <1>;
-                #size-cells = <0>;
-
                 vin1ep0: endpoint {
                         remote-endpoint = <&adv7180>;
                         bus-width = <8>;
-- 
2.11.0
