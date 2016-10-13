From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 13 Oct 2016 16:32:06 -0500
Subject: [PATCH 1/4] dt-bindings: mfd: Add Altera Arria10 SR Monitor
In-Reply-To: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
References: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1476394329-31696-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the Arria10 DevKit System Resource Chip register and state
monitoring module to the MFD.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
Note: This needs to be applied to the bindings document that
was Acked & Applied but didn't reach the for-next branch.
See https://patchwork.ozlabs.org/patch/629397/
---
---
 .../devicetree/bindings/mfd/altera-a10sr.txt       |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
index ea151f2..0787ec6 100644
--- a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
+++ b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
@@ -18,6 +18,7 @@ The A10SR consists of these sub-devices:
 Device                   Description
 ------                   ----------
 a10sr_gpio               GPIO Controller
+a10sr_monitor            Register and State Monitoring
 
 Arria10 GPIO
 Required Properties:
@@ -27,6 +28,10 @@ Required Properties:
                       the second cell is used to specify flags.
                       See ../gpio/gpio.txt for more information.
 
+Arria10 Register and State Monitor
+Required Properties:
+- compatible        : Should be "altr,a10sr-mon"
+
 Example:
 
         resource-manager at 0 {
@@ -43,4 +48,8 @@ Example:
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		a10sr_monitor {
+			compatible = "altr,a10sr-mon";
+		};
 	};
-- 
1.7.9.5
