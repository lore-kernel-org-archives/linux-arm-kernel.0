From: haibo.chen@freescale.com (Haibo Chen)
Date: Mon, 27 Jul 2015 19:26:44 +0800
Subject: [PATCH 2/5] Documentation: Detail permitted DT properties for the
 imx6ul_tsc
In-Reply-To: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we apply required documentation for the imx6ul touch screen
controller driver which describe available properties and how to
use them.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
new file mode 100644
index 0000000..e34d752
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
@@ -0,0 +1,14 @@
+* Freescale i.MX6UL Touch Controller
+
+Required properties:
+- compatible: must be "fsl,imx6ul-tsc"
+
+Example:
+	&tsc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc>;
+		status = "okay";
+		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		measure_delay_time = <0xfff>;
+		pre_charge_time = <0xffff>;
+	};
-- 
1.9.1
