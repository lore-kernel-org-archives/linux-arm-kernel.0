From: b44548@freescale.com (Chao Fu)
Date: Fri, 16 Aug 2013 11:08:54 +0800
Subject: [PATCH v3 3/4] Documentation: DT: Add Freescale DSPI driver
In-Reply-To: <1376622535-8474-1-git-send-email-b44548@freescale.com>
References: <1376622535-8474-1-git-send-email-b44548@freescale.com>
Message-ID: <1376622535-8474-4-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

This patch adds the document for DSPI driver under
Documentation/devicetree/bindings/spi/.

Signed-off-by: Chao Fu <b44548@freescale.com>
---
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
new file mode 100644
index 0000000..a1fb303
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -0,0 +1,42 @@
+ARM Freescale DSPI controller
+
+Required properties:
+- compatible : "fsl,vf610-dspi"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain SPI controller interrupt
+- clocks: from common clock binding: handle to dspi clock.
+- clock-names: from common clock binding: Shall be "dspi".
+- pinctrl-0: pin control group to be used for this controller.
+- pinctrl-names: must contain a "default" entry.
+- spi-num-chipselects : the number of the chipselect signals.
+- bus-num : the slave chip chipselect signal number.
+Example:
+
+dspi0 at 4002c000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,vf610-dspi";
+	reg = <0x4002c000 0x1000>;
+	interrupts = <0 67 0x04>;
+	clocks = <&clks VF610_CLK_DSPI0>;
+	clock-names = "dspi";
+	spi-num-chipselects = <5>;
+	bus-num = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dspi0_1>;
+	status = "okay";
+
+	sflash: at26df081a at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at26df081a";
+		spi-max-frequency = <16000000>;
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		linux,modalias = "m25p80";
+		modal = "at26df081a";
+	};
+};
+
+
-- 
1.8.0
