From: mporter@ti.com (Matt Porter)
Date: Fri, 28 Sep 2012 15:37:48 -0400
Subject: [PATCH v2 3/7] uio: dt: add TI PRUSS binding
In-Reply-To: <1348861072-14507-1-git-send-email-mporter@ti.com>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
Message-ID: <1348861072-14507-4-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a DT binding definition for the TI PRUSS.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 Documentation/devicetree/bindings/uio/pruss.txt |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uio/pruss.txt

diff --git a/Documentation/devicetree/bindings/uio/pruss.txt b/Documentation/devicetree/bindings/uio/pruss.txt
new file mode 100644
index 0000000..2ac45c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/uio/pruss.txt
@@ -0,0 +1,17 @@
+TI PRUSS device
+
+Required properties:
+- compatible :
+  - "ti,pruss-v1" for AM18xx/OMAP-L138/DA850
+  - "ti,pruss-v2" for AM33xx.
+- ti,pintc-offset : Offset of the PINTC from the PRUSS address base
+- ti,hwmods: Name of the hwmod associated to the PRUSS
+
+Example:
+
+pruss: pruss at 4a300000 {
+	compatible = "ti,pruss-v2";
+	ti,hwmods = "pruss";
+	reg = <0x4a300000 0x080000>;
+	ti,pintc-offset = <0x20000>;
+};
-- 
1.7.9.5
