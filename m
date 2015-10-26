From: yvo@apm.com (Y Vo)
Date: Mon, 26 Oct 2015 13:49:34 +0700
Subject: [PATCH v2 2/3] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <1445842175-11446-1-git-send-email-yvo@apm.com>
References: <1445842175-11446-1-git-send-email-yvo@apm.com>
Message-ID: <1445842175-11446-3-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update description for X-Gene standby GPIO controller DTS binding to
support GPIO line configuration as input, output or external IRQ pin.

Signed-off-by: Y Vo <yvo@apm.com>
---
 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |   23 +++++++++++++-------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
index dae1300..7c0e7f4 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
@@ -3,8 +3,7 @@ APM X-Gene Standby GPIO controller bindings
 This is a gpio controller in the standby domain.
 
 There are 20 GPIO pins from 0..21. There is no GPIO_DS14 or GPIO_DS15,
-only GPIO_DS8..GPIO_DS13 support interrupts. The IRQ mapping
-is currently 1-to-1 on interrupts 0x28 thru 0x2d.
+only GPIO_DS8..GPIO_DS13 support interrupts.
 
 Required properties:
 - compatible: "apm,xgene-gpio-sb" for the X-Gene Standby GPIO controller
@@ -16,6 +15,11 @@ Required properties:
 		1 = active low
 - gpio-controller: Marks the device node as a GPIO controller.
 - interrupts: Shall contain exactly 6 interrupts.
+- interrupt-parent: Phandle of the parent interrupt controller.
+- interrupt-cells: Shoule be two.
+	- first cell is 0-5 coresponding for GPIO pin 8..13.
+	- second cell is used to specify flags.
+- interrupt-controller: Marks the device node as an interrupt controller.
 
 Example:
 	sbgpio: sbgpio at 17001000 {
@@ -23,10 +27,13 @@ Example:
 		reg = <0x0 0x17001000 0x0 0x400>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		interrupts = 	<0x0 0x28 0x1>,
-				<0x0 0x29 0x1>,
-				<0x0 0x2a 0x1>,
-				<0x0 0x2b 0x1>,
-				<0x0 0x2c 0x1>,
-				<0x0 0x2d 0x1>;
+		interrupt-parent = <&gic>;
+		interrupts = 	<0x0 0x28 0x4>,
+				<0x0 0x29 0x4>,
+				<0x0 0x2a 0x4>,
+				<0x0 0x2b 0x4>,
+				<0x0 0x2c 0x4>,
+				<0x0 0x2d 0x4>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
 	};
-- 
1.7.1
