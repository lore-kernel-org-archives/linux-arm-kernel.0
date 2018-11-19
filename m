From: sugaya.taichi@socionext.com (Sugaya Taichi)
Date: Mon, 19 Nov 2018 10:01:09 +0900
Subject: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer description
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Message-ID: <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings document for Milbeaut M10V timer.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
new file mode 100644
index 0000000..ddb1b31
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
@@ -0,0 +1,17 @@
+Milbeaut SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "socionext,milbeaut-m10v-timer"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+- clocks: should be "rclk"
+
+Example:
+
+timer {
+	compatible = "socionext,milbeaut-m10v-timer";
+	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
+	interrupts = <0 91 4>;
+	clocks = <&rclk>;
+};
-- 
1.9.1
