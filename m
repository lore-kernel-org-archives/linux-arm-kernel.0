From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Thu, 5 Nov 2015 11:02:25 +0800
Subject: [PATCH V2 1/3] dt-bindings: gpio: Documentation for Hi6220 gpio driver
Message-ID: <1446692547-78129-1-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dt-bindings: gpio: Documentation for Hi6220 gpio driver

Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>

Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gpio/gpio-hi6220.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-hi6220.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt b/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt
new file mode 100644
index 0000000..a9cbf21
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt
@@ -0,0 +1,23 @@
+Hisilicon Hi6220 GPIO controller bindings
+
+Required properties:
+	- compatible: "arm,pl061","arm,primecell"
+	- gpio-controller: Marks the device node as a GPIO controller.
+	- #gpio-cells: Should be 2. See gpio.txt in this directory for a
+		 description of	the cells format.
+	- interrupt-controller: Mark the device node as an interrupt controller
+
+Example:
+
+	gpio0: gpio at f8011000 {
+		compatible = "arm,pl061", "arm,primecell";
+		reg = <0x0 0xf8011000 0x0 0x1000>;
+		interrupts = <0	52 0x4>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&ao_ctrl 2>;
+		clock-names = "apb_pclk";
+		status = "ok";
+	};
-- 
1.9.1
