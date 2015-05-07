From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 8 May 2015 01:35:53 +0800
Subject: [PATCH V8 1/6] Document: dt: binding: imx: update document for imx7d
 support
In-Reply-To: <1431020158-13789-1-git-send-email-Frank.Li@freescale.com>
References: <1431020158-13789-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1431020158-13789-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

This part just add necessary change to boot imx7d.
Update clock, pinctrl and gpt for imx7d

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 .../devicetree/bindings/clock/imx7d-clock.txt      | 13 +++++++++++
 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         | 27 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/clock/imx7d-clock.txt b/Documentation/devicetree/bindings/clock/imx7d-clock.txt
new file mode 100644
index 0000000..9d3026d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7d-clock.txt
@@ -0,0 +1,13 @@
+* Clock bindings for Freescale i.MX7 Dual
+
+Required properties:
+- compatible: Should be "fsl,imx7d-ccm"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of clock specifiers, must contain an entry for each required
+  entry in clock-names
+- clock-names: should include entries "ckil", "osc"
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx7d-clock.h
+for the full list of i.MX7 Dual clock IDs.
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
new file mode 100644
index 0000000..8bbf25d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
@@ -0,0 +1,27 @@
+* Freescale i.MX7 Dual IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
+and usage.
+
+Required properties:
+- compatible: "fsl,imx7d-iomuxc"
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx7d-pinfunc.h under device tree source folder.  The last integer CONFIG is
+  the pad setting value like pull-up on this pin.  Please refer to i.MX7 Dual
+  Reference Manual for detailed CONFIG settings.
+
+CONFIG bits definition:
+PAD_CTL_PUS_100K_DOWN           (0 << 5)
+PAD_CTL_PUS_5K_UP               (1 << 5)
+PAD_CTL_PUS_47K_UP              (2 << 5)
+PAD_CTL_PUS_100K_UP             (3 << 5)
+PAD_CTL_PUE                     (1 << 4)
+PAD_CTL_HYS                     (1 << 3)
+PAD_CTL_SRE_SLOW                (1 << 2)
+PAD_CTL_SRE_FAST                (0 << 2)
+PAD_CTL_DSE_X1                  (0 << 0)
+PAD_CTL_DSE_X2                  (1 << 0)
+PAD_CTL_DSE_X3                  (2 << 0)
+PAD_CTL_DSE_X4                  (3 << 0)
-- 
1.9.1
