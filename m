From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 17 Aug 2017 09:15:25 +0200
Subject: [PATCH v3 1/2] remoteproc: dt: Provide bindings for iMX6SX/7D Remote
 Processor Controller driver
In-Reply-To: <20170817071526.5930-1-o.rempel@pengutronix.de>
References: <20170817071526.5930-1-o.rempel@pengutronix.de>
Message-ID: <20170817071526.5930-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/remoteproc/imx-rproc.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
new file mode 100644
index 000000000000..fbcefd965dc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
@@ -0,0 +1,33 @@
+NXP iMX6SX/iMX7D Co-Processor Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+NXP iMX SoCs.
+
+Required properties:
+- compatible		Should be one of:
+				"fsl,imx7d-cm4"
+				"fsl,imx6sx-cm4"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+- syscon		Phandle to syscon block which provide access to
+			System Reset Controller
+
+Optional properties:
+- memory-region		list of phandels to the reserved memory regions.
+			(See: ../reserved-memory/reserved-memory.txt)
+
+Example:
+	m4_reserved_sysmem1: cm4 at 80000000 {
+		reg = <0x80000000 0x80000>;
+	};
+
+	m4_reserved_sysmem2: cm4 at 81000000 {
+		reg = <0x81000000 0x80000>;
+	};
+
+	imx7d-cm4 {
+		compatible	= "fsl,imx7d-cm4";
+		memory-region	= <&m4_reserved_sysmem1>, <&m4_reserved_sysmem2>;
+		syscon		= <&src>;
+		clocks		= <&clks IMX7D_ARM_M4_ROOT_CLK>;
+	};
-- 
2.11.0
