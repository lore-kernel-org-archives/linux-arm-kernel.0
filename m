From: yvo@apm.com (Y Vo)
Date: Fri, 16 Jan 2015 14:34:20 +0700
Subject: [PATCH v3 2/3] Documentation: gpio: Add APM X-Gene standby GPIO
 controller DTS binding
In-Reply-To: <1421393661-4311-1-git-send-email-yvo@apm.com>
References: <1421393661-4311-1-git-send-email-yvo@apm.com>
Message-ID: <1421393661-4311-3-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation for APM X-Gene standby GPIO controller DTS binding.

Signed-off-by: Y Vo <yvo@apm.com>
---
 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |   31 ++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
new file mode 100644
index 0000000..3215e4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
@@ -0,0 +1,31 @@
+APM X-Gene Standby GPIO controller bindings
+
+This is a gpio controller in standby domain.
+
+There are 20 GPIO pins from 0..21. There is no GPIO_DS14 and GPIO_DS15. 
+Only GPIO_DS8..GPIO_DS13 support interrupt. IRQ mapping 0x28..0x2d.
+
+Required properties:
+- compatible: "apm,xgene-gpio-sb" for X-Gene Standby GPIO controller
+- reg: Physical base address and size of the controller's registers
+- #gpio-cells: Should be two.
+	- first cell is the pin number
+	- second cell is used to specify the gpio polarity:
+		0 = active high
+		1 = active low
+- gpio-controller: Marks the device node as a GPIO controller.
+- interrupts: Shall contains the interrupts.
+
+Example:
+	sbgpio: sbgpio at 17001000 {
+		compatible = "apm,xgene-gpio-sb";
+		reg = <0x0 0x17001000 0x0 0x400>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupts = 	<0x0 0x28 0x1>,
+				<0x0 0x29 0x1>,
+				<0x0 0x2a 0x1>,
+				<0x0 0x2b 0x1>,
+				<0x0 0x2c 0x1>,
+				<0x0 0x2d 0x1>;
+	};
-- 
1.7.1
