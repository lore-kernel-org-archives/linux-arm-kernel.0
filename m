From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 17 Jan 2018 19:28:03 +0100
Subject: [PATCH 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Message-ID: <20180117182804.26323-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the binding for the i.MX8MQ pin controller, in the same
fashion as earlier i.MX SoCs.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../bindings/pinctrl/nxp,imx8mq-pinctrl.txt        | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,imx8mq-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,imx8mq-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/nxp,imx8mq-pinctrl.txt
new file mode 100644
index 000000000000..2f7e88356321
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,imx8mq-pinctrl.txt
@@ -0,0 +1,33 @@
+* NXP IMX8MQ IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
+and usage.
+
+Required properties:
+- compatible: "nxp,imx8mq-iomuxc"
+- fsl,pins: two integers array, represents a group of pins mux and config
+  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
+  pin working on a specific function, CONFIG is the pad setting value like
+  pull-up for this pin. Please refer to imx8mq datasheet for the valid pad
+  config settings.
+
+CONFIG bits definition:
+PAD_CTL_LVTTL                   (1 << 8)
+PAD_CTL_HYS                     (1 << 7)
+PAD_CTL_PUE                     (1 << 6)
+PAD_CTL_ODE                     (1 << 5)
+PAD_CTL_SRE_MAX                 (3 << 3)
+PAD_CTL_SRE_FAST                (2 << 3)
+PAD_CTL_SRE_MEDIUM              (1 << 3)
+PAD_CTL_SRE_SLOW                (0 << 3)
+PAD_CTL_DSE_DISABLE             (0 << 0)
+PAD_CTL_DSE_255ohm              (1 << 0)
+PAD_CTL_DSE_105ohm              (2 << 0)
+PAD_CTL_DSE_75ohm               (3 << 0)
+PAD_CTL_DSE_85ohm               (4 << 0)
+PAD_CTL_DSE_65ohm               (5 << 0)
+PAD_CTL_DSE_45ohm               (6 << 0)
+PAD_CTL_DSE_40ohm               (7 << 0)
+
+Refer to imx8mq-pinfunc.h in device tree source folder for all available
+imx8mq PIN_FUNC_ID.
-- 
2.11.0
