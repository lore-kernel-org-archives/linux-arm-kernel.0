From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Sat, 31 Oct 2015 10:24:19 +0800
Subject: [PATCH 2/3] dt-bindings: gpio: Documentation for Hi6220 gpio driver
In-Reply-To: <1446258260-72902-1-git-send-email-zhongkaihua@huawei.com>
References: <1446258260-72902-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1446258260-72902-2-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dt-bindings: gpio: Documentation for Hi6220 gpio driver

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
---
 .../devicetree/bindings/gpio/gpio-hi6220.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-hi6220.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt b/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt
new file mode 100644
index 0000000..76a8932
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt
@@ -0,0 +1,23 @@
+Hisilicon Hi6220 GPIO controller bindings
+
+Required properties:
+  - compatible:	"arm,pl061", "arm,primecell"
+  - gpio-controller: Marks the device node as a	GPIO controller.
+  - #gpio-cells: Should	be 2. See gpio.txt in this directory for a
+		 description of	the cells format.
+  - interrupt-controller: Mark the device node as an interrupt controller
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
