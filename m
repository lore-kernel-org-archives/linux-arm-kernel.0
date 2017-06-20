From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 20 Jun 2017 09:09:30 +0200
Subject: [PATCH v7 1/3] nvmem: dt: document SNVS LPGPR binding
In-Reply-To: <20170620070932.10353-1-o.rempel@pengutronix.de>
References: <20170620070932.10353-1-o.rempel@pengutronix.de>
Message-ID: <20170620070932.10353-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation bindings for the Low Power General Purpose Register
available on i.MX6 SoCs in the Secure Non-Volatile Storage.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/nvmem/snvs-lpgpr.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt

diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
new file mode 100644
index 000000000000..20bc49b49799
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
@@ -0,0 +1,20 @@
+Device tree bindings for Low Power General Purpose Register found in i.MX6Q/D
+Secure Non-Volatile Storage.
+
+This DT node should be represented as a sub-node of a "syscon",
+"simple-mfd" node.
+
+Required properties:
+- compatible: should be one of the fallowing variants:
+	"fsl,imx6q-snvs-lpgpr" for Freescale i.MX6Q/D/DL/S
+	"fsl,imx6ul-snvs-lpgpr" for Freescale i.MX6UL
+
+Example:
+snvs: snvs at 020cc000 {
+	compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+	reg = <0x020cc000 0x4000>;
+
+	snvs_lpgpr: snvs-lpgpr {
+		compatible = "fsl,imx6q-snvs-lpgpr";
+	};
+};
-- 
2.11.0
