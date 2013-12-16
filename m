From: b32955@freescale.com (Huang Shijie)
Date: Mon, 16 Dec 2013 16:58:49 +0800
Subject: [PATCH v3 6/7] Documentation: add the binding file for Quadspi driver
In-Reply-To: <1387184330-14448-1-git-send-email-b32955@freescale.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
Message-ID: <1387184330-14448-7-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding file for Freescale Quadspi driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   31 ++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
new file mode 100644
index 0000000..3475cfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -0,0 +1,31 @@
+* Freescale Quad Serial Peripheral Interface(QuadSPI)
+
+Required properties:
+- compatible : Should be "fsl,vf610-qspi"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain the interrupt for the device
+- clocks : The clocks needed by the QuadSPI controller
+- clock-names : the name of the clocks
+- fsl,nor-num : Contains the number of SPI NOR chips connected to
+                the controller.
+- fsl,nor-size : the size of each SPI NOR.
+- fsl,max-frequency : the frequency at which the SPI NOR works.
+
+Example:
+
+qspi0: quadspi at 40044000 {
+	compatible = "fsl,vf610-qspi";
+	reg = <0x40044000 0x1000>;
+	interrupts = <0 24 0x04>;
+	clocks = <&clks VF610_CLK_QSPI0_EN>,
+		<&clks VF610_CLK_QSPI0>;
+	clock-names = "qspi_en", "qspi";
+	fsl,nor-num = <1>;
+	fsl,nor-size = <0x1000000>;
+	fsl,max-frequency = <66000000>;
+	status = "okay";
+
+	flash0: s25fl128s at 0 {
+		....
+	};
+};
-- 
1.7.2.rc3
