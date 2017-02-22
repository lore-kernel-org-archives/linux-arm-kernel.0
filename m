From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 22 Feb 2017 11:10:15 -0600
Subject: [PATCHv2 1/5] dt-bindings: mfd: Add Altera Arria10 SR Reset
 Controller bindings
In-Reply-To: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
References: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1487783419-10912-2-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch adds documentation for the Altera A10-SR Reset
Controller DT bindings.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  No change
---
 Documentation/devicetree/bindings/mfd/altera-a10sr.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
index ea151f2..c8a7365 100644
--- a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
+++ b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
@@ -18,6 +18,7 @@ The A10SR consists of these sub-devices:
 Device                   Description
 ------                   ----------
 a10sr_gpio               GPIO Controller
+a10sr_rst                Reset Controller
 
 Arria10 GPIO
 Required Properties:
@@ -27,6 +28,11 @@ Required Properties:
                       the second cell is used to specify flags.
                       See ../gpio/gpio.txt for more information.
 
+Arria10 Peripheral PHY Reset
+Required Properties:
+- compatible        : Should be "altr,a10sr-reset"
+- #reset-cells      : Should be one.
+
 Example:
 
         resource-manager at 0 {
@@ -43,4 +49,9 @@ Example:
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		a10sr_rst: reset-controller {
+			compatible = "altr,a10sr-reset";
+			#reset-cells = <1>;
+		};
 	};
-- 
1.9.1
