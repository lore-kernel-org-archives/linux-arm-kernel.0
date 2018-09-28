From: vigneshr@ti.com (Vignesh R)
Date: Fri, 28 Sep 2018 10:55:56 +0530
Subject: [PATCH v2 1/2] dt-bindings: i2c-omap: Add new compatible for AM654
 SoCs
In-Reply-To: <20180928052557.21663-1-vigneshr@ti.com>
References: <20180928052557.21663-1-vigneshr@ti.com>
Message-ID: <20180928052557.21663-2-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM654 SoCs have same I2C IP as OMAP SoCs. Add new compatible to
handle AM654 SoCs. While at that reformat the existing compatible list
for older SoCs to list one valid compatible per line.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: Reformat compatible existing compatible list.

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
index 7e49839d4124..4b90ba9f31b7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -1,8 +1,12 @@
 I2C for OMAP platforms
 
 Required properties :
-- compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
-  or "ti,omap4-i2c"
+- compatible : Must be
+	"ti,omap2420-i2c" for OMAP2420 SoCs
+	"ti,omap2430-i2c" for OMAP2430 SoCs
+	"ti,omap3-i2c" for OMAP3 SoCs
+	"ti,omap4-i2c" for OMAP4+ SoCs
+	"ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
2.19.0
