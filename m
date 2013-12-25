From: b32955@freescale.com (Huang Shijie)
Date: Wed, 25 Dec 2013 13:50:28 +0800
Subject: [PATCH v4 6/7] Documentation: add the binding file for Freescale
 QuadSPI driver
In-Reply-To: <1387950629-27448-1-git-send-email-b32955@freescale.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
Message-ID: <1387950629-27448-7-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding file for Freescale QuadSPI driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   26 ++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
new file mode 100644
index 0000000..77ba6a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -0,0 +1,26 @@
+* Freescale Quad Serial Peripheral Interface(QuadSPI)
+
+Required properties:
+- compatible : Should be "fsl,vf610-qspi"
+- reg : the first contains the register location and length,
+        the second contains the memory mapping address and length
+- reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
+- interrupts : Should contain the interrupt for the device
+- clocks : The clocks needed by the QuadSPI controller
+- clock-names : the name of the clocks
+
+Example:
+
+qspi0: quadspi at 40044000 {
+	compatible = "fsl,vf610-qspi";
+	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
+	reg-names = "QuadSPI", "QuadSPI-memory";
+	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks VF610_CLK_QSPI0_EN>,
+		<&clks VF610_CLK_QSPI0>;
+	clock-names = "qspi_en", "qspi";
+
+	flash0: s25fl128s at 0 {
+		....
+	};
+};
-- 
1.7.2.rc3
