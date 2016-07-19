From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Jul 2016 15:42:17 +0200
Subject: [PATCH v3 1/6] dt-bindings: clock: add DT binding for the Xtal clock
 on Armada 3700
In-Reply-To: <1468935742-11218-1-git-send-email-gregory.clement@free-electrons.com>
References: <1468935742-11218-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1468935742-11218-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the DT binding documentation for the the Xtal clock on
Armada 3700 used in the Marvell Armada 3700 SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/armada3700-xtal-clock.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
new file mode 100644
index 000000000000..a88f1f05fbd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
@@ -0,0 +1,28 @@
+* Xtal Clock bindings for Marvell Armada 37xx SoCs
+
+Marvell Armada 37xx SoCs allow to determine the xtal clock frequencies by
+reading the gpio latch register.
+
+This node must be a subnode of the node exposing the register address
+of the GPIO block where the gpio latch is located.
+
+Required properties:
+- compatible : shall be one of the following:
+	"marvell,armada-3700-xtal-clock"
+- #clock-cells : from common clock binding; shall be set to 0
+
+Optional properties:
+- clock-output-names : from common clock binding; allows overwrite default clock
+	output names ("xtal")
+
+Example:
+gpio1: gpio at 13800 {
+	compatible = "marvell,armada-3700-gpio", "syscon", "simple-mfd";
+	reg = <0x13800 0x1000>;
+
+	xtalclk: xtal-clk {
+		compatible = "marvell,armada-3700-xtal-clock";
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+};
-- 
2.5.0
