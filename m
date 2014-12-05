From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Fri,  5 Dec 2014 11:38:42 +0800
Subject: [PATCH v4 4/4] Documentation: dt: gpio: Add gpio-number-forward
 property in snps gpio binding doc
In-Reply-To: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
References: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <1417750722-14027-5-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property is used to indicate gpiochip_find_base() to find GPIO
base number in increasing order.

Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
---
 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
index dd5d2c0..b7f01c8 100644
--- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
@@ -29,6 +29,7 @@ controller.
 - interrupts : The interrupt to the parent controller raised when GPIOs
   generate the interrupts.
 - snps,nr-gpios : The number of pins in the port, a single cell.
+- gpio-number-forward : Will find GPIO base number in increasing order.
 
 Example:
 
@@ -37,6 +38,7 @@ gpio: gpio at 20000 {
 	reg = <0x20000 0x1000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	gpio-number-forward;
 
 	porta: gpio-controller at 0 {
 		compatible = "snps,dw-apb-gpio-port";
-- 
1.7.9.5
