From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 30 Aug 2018 21:01:12 +0200
Subject: [PATCH v4 05/13] dt-bindings: phy: document sun4i-a10-sata-phy
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Message-ID: <20180830190120.722-6-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch document the sun4i-a10-sata-phy bindings.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 .../devicetree/bindings/phy/sun4i-sata-phy.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt
new file mode 100644
index 000000000000..f031542717c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt
@@ -0,0 +1,20 @@
+Allwinner sun4i SATA PHY
+-----------------------
+
+Required properties:
+- compatible : should be one of
+  * allwinner,sun4i-a10-sata-phy
+  * allwinner,sun8i-r40-sata-phy
+- reg : a list of offset + length pairs
+- #phy-cells : from the generic phy bindings, must be 0
+
+Optional properties:
+- phy-supply : from the generic phy bindings, a phandle to a regulator that
+	       provides power to the PHY.
+
+Example:
+	sata_phy0: sata-phy at a01800 {
+		compatible = "allwinner,sun8i-r40-sata-phy";
+		reg = <0x00a01800 0x4>;
+		#phy-cells = <0>;
+	};
-- 
2.16.4
