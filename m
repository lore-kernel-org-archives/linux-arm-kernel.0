From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 10 Aug 2018 17:18:20 +0200
Subject: [PATCH 1/3] dt-bindings: media: Add i.MX Pixel Pipeline binding
In-Reply-To: <20180810151822.18650-1-p.zabel@pengutronix.de>
References: <20180810151822.18650-1-p.zabel@pengutronix.de>
Message-ID: <20180810151822.18650-2-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for the Pixel Pipeline (PXP) found on
various NXP i.MX SoCs.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/media/fsl-pxp.txt     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/fsl-pxp.txt

diff --git a/Documentation/devicetree/bindings/media/fsl-pxp.txt b/Documentation/devicetree/bindings/media/fsl-pxp.txt
new file mode 100644
index 000000000000..2477e7f87381
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/fsl-pxp.txt
@@ -0,0 +1,26 @@
+Freescale Pixel Pipeline
+========================
+
+The Pixel Pipeline (PXP) is a memory-to-memory graphics processing engine
+that supports scaling, colorspace conversion, alpha blending, rotation, and
+pixel conversion via lookup table. Different versions are present on various
+i.MX SoCs from i.MX23 to i.MX7.
+
+Required properties:
+- compatible: should be "fsl,<soc>-pxp", where SoC can be one of imx23, imx28,
+  imx6dl, imx6sl, imx6ul, imx6sx, imx6ull, or imx7d.
+- reg: the register base and size for the device registers
+- interrupts: the PXP interrupt, two interrupts for imx6ull and imx7d.
+- clock-names: should be "axi"
+- clocks: the PXP AXI clock
+
+Example:
+
+pxp at 21cc000 {
+	compatible = "fsl,imx6ull-pxp";
+	reg = <0x021cc000 0x4000>;
+	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "axi";
+	clocks = <&clks IMX6UL_CLK_PXP>;
+};
-- 
2.18.0
