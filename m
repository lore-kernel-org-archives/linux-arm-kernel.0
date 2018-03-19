From: ping.bai@nxp.com (Bai Ping)
Date: Mon, 19 Mar 2018 15:16:38 +0800
Subject: [PATCH v6 1/2] dt-bindings: imx: update pinctrl doc for imx6sll
Message-ID: <1521443799-31792-1-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl binding doc update for imx6sll.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 changes v2-v3:
 - add generic config binding

 change v3->v4:
 - add SION bit define
 - fix typo
 - move the pin header file to dts patch.

 change v4->v5: 
 - drop generic config, use the old fsl pin config style

 change v5->v6:
 - no change
---

 .../bindings/pinctrl/fsl,imx6sll-pinctrl.txt       | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
new file mode 100644
index 0000000..175e893
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
@@ -0,0 +1,40 @@
+* Freescale i.MX6 SLL IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
+and usage.
+
+Required properties:
+- compatible: "fsl,imx6sll-iomuxc"
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx6sll-pinfunc.h under device tree source folder.  The last integer CONFIG is
+  the pad setting value like pull-up on this pin.  Please refer to i.MX6SLL
+  Reference Manual for detailed CONFIG settings.
+
+CONFIG bits definition:
+PAD_CTL_LVE			(1 << 22)
+PAD_CTL_HYS                     (1 << 16)
+PAD_CTL_PUS_100K_DOWN           (0 << 14)
+PAD_CTL_PUS_47K_UP              (1 << 14)
+PAD_CTL_PUS_100K_UP             (2 << 14)
+PAD_CTL_PUS_22K_UP              (3 << 14)
+PAD_CTL_PUE                     (1 << 13)
+PAD_CTL_PKE                     (1 << 12)
+PAD_CTL_ODE                     (1 << 11)
+PAD_CTL_SPEED_LOW               (0 << 6)
+PAD_CTL_SPEED_MED               (1 << 6)
+PAD_CTL_SPEED_HIGH              (3 << 6)
+PAD_CTL_DSE_DISABLE             (0 << 3)
+PAD_CTL_DSE_260ohm              (1 << 3)
+PAD_CTL_DSE_130ohm              (2 << 3)
+PAD_CTL_DSE_87ohm               (3 << 3)
+PAD_CTL_DSE_65ohm               (4 << 3)
+PAD_CTL_DSE_52ohm               (5 << 3)
+PAD_CTL_DSE_43ohm               (6 << 3)
+PAD_CTL_DSE_37ohm               (7 << 3)
+PAD_CTL_SRE_FAST                (1 << 0)
+PAD_CTL_SRE_SLOW                (0 << 0)
+
+Refer to imx6sll-pinfunc.h in device tree source folder for all available
+imx6sll PIN_FUNC_ID.
-- 
1.9.1
