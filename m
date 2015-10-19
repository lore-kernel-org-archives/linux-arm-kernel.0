From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:12 +0530
Subject: [PATCH 05/11] dt-binding: Add ngpios property to GPIO controller node
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-6-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ngpios property to the gpio controller's DT node so that controller
driver extracts total number of gpio lines present in controller
from DT and removes dependency on driver.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
index f92b833..655a8d7 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
@@ -10,6 +10,9 @@ Required properties:
     Define the base and range of the I/O address space that contains the Cygnus
 GPIO/PINCONF controller registers
 
+- ngpios:
+    Total number of GPIOs the controller provides
+
 - #gpio-cells:
     Must be two. The first cell is the GPIO pin number (within the
 controller's pin space) and the second cell is used for the following:
@@ -57,6 +60,7 @@ Example:
 		compatible = "brcm,cygnus-ccm-gpio";
 		reg = <0x1800a000 0x50>,
 		      <0x0301d164 0x20>;
+		ngpios = <24>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -78,6 +82,7 @@ Example:
 	gpio_asiu: gpio at 180a5000 {
 		compatible = "brcm,cygnus-asiu-gpio";
 		reg = <0x180a5000 0x668>;
+		ngpios = <146>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
