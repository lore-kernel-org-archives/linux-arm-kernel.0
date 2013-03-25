From: avinashphilip@ti.com (Philip Avinash)
Date: Mon, 25 Mar 2013 12:34:52 +0530
Subject: [PATCH 1/2] pwm: pwm-tiecap: Update device-tree binding document
In-Reply-To: <1364195093-1357-1-git-send-email-avinashphilip@ti.com>
References: <1364195093-1357-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1364195093-1357-2-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update binding document of pwm-tiecap to reflect the usage of similar
modules in da850 and am3xx SOCs.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
---
 .../devicetree/bindings/pwm/pwm-tiecap.txt         |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 131e8c1..43c4e81 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -1,7 +1,9 @@
 TI SOC ECAP based APWM controller
 
 Required properties:
-- compatible: Must be "ti,am33xx-ecap"
+- compatible: Must be "ti,<soc>-ecap".
+  for am33xx - compatible = "ti,am33xx-ecap";
+  for da850  - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
 - #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
   First cell specifies the per-chip index of the PWM to use, the second
   cell is the period in nanoseconds and bit 0 in the third cell is used to
@@ -15,9 +17,15 @@ Optional properties:
 
 Example:
 
-ecap0: ecap at 0 {
+ecap0: ecap at 0 {  /* ECAP on am33xx */
 	compatible = "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x48300100 0x80>;
 	ti,hwmods = "ecap0";
 };
+
+ecap0: ecap at 0 { /* ECAP on da850 */
+	compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+	#pwm-cells = <3>;
+	reg = <0x306000 0x80>;
+};
-- 
1.7.9.5
