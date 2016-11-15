From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 15 Nov 2016 15:29:13 +0100
Subject: [PATCH net 2/3] dt-bindings: net: add DT bindings for realtek phys
In-Reply-To: <1479220154-25851-1-git-send-email-jbrunet@baylibre.com>
References: <1479220154-25851-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1479220154-25851-3-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/net/realtek-phy.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-phy.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-phy.txt b/Documentation/devicetree/bindings/net/realtek-phy.txt
new file mode 100644
index 000000000000..dc2845a6b387
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-phy.txt
@@ -0,0 +1,20 @@
+Realtek Ethernet PHY
+
+Some boards require special tuning values of the phy.
+
+Optional properties:
+
+realtek,disable-eee-1000t:
+realtek,disable-eee-100tx:
+  If set, respectively disable 1000-BaseT and 100-BaseTx energy efficient
+  ethernet capabilty advertisement
+  default: Leave the phy default settings unchanged (capabilities advertised)
+
+Example:
+
+&mdio0 {
+	ethernetphy0: ethernet-phy at 0 {
+		reg = <0>;
+		realtek,disable-eee-1000t;
+	};
+};
-- 
2.7.4
