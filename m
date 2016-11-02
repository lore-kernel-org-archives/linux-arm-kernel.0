From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 2 Nov 2016 09:32:55 -0500
Subject: [PATCHv3 1/4] dt-bindings: mfd: Add Altera Arria10 SR Monitor
In-Reply-To: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
References: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1478097178-24341-2-git-send-email-tthayer@opensource.altera.com>
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
v2  Change compatible string -mon to -monitor for clarity
v3  Replace node name a10sr_monitor with just monitor.
    Replace node name a10sr_gpio with just gpio.
---
 Documentation/devicetree/bindings/mfd/altera-a10sr.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
index ea151f2..69243d2 100644
--- a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
+++ b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
@@ -17,7 +17,8 @@ The A10SR consists of these sub-devices:
 
 Device                   Description
 ------                   ----------
-a10sr_gpio               GPIO Controller
+gpio                     GPIO Controller
+monitor                  Register and State Monitoring
 
 Arria10 GPIO
 Required Properties:
@@ -27,6 +28,10 @@ Required Properties:
                       the second cell is used to specify flags.
                       See ../gpio/gpio.txt for more information.
 
+Arria10 Register and State Monitor
+Required Properties:
+- compatible        : Should be "altr,a10sr-monitor"
+
 Example:
 
         resource-manager at 0 {
@@ -43,4 +48,8 @@ Example:
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		monitor {
+			compatible = "altr,a10sr-monitor";
+		};
 	};
-- 
1.9.1
