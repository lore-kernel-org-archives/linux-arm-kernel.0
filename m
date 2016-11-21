From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Nov 2016 16:35:23 +0100
Subject: [RFC PATCH net v2 2/3] dt: bindings: add ethernet phy
 eee-disable-advert option documentation
In-Reply-To: <1479742524-30222-1-git-send-email-jbrunet@baylibre.com>
References: <1479742524-30222-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1479742524-30222-3-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/net/phy.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index bc1c3c8bf8fa..7f066b7c1e2c 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -35,6 +35,11 @@ Optional Properties:
 - broken-turn-around: If set, indicates the PHY device does not correctly
   release the turn around line low at the end of a MDIO transaction.
 
+- eee-advert-disable: Bits to clear in the MDIO_AN_EEE_ADV register to
+  disable EEE modes. Example
+    * 0x4: disable EEE for 1000T,
+    * 0x6: disable EEE for 100TX and 1000T
+
 Example:
 
 ethernet-phy at 0 {
-- 
2.7.4
