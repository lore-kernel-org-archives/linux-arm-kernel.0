From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 26 Apr 2016 17:36:43 -0500
Subject: [PATCH v7 3/9] pwm: pwm-tiehrpwm: Update dt binding document to use
 generic node name
In-Reply-To: <1461710209-6563-1-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Message-ID: <1461710209-6563-4-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the node name has been changed from ehrpwm to pwm the document
should show this proper usage. Also change the unit address in the example
from 0 to the proper physical address value that should be used.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 99b544f..cbc538b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -16,21 +16,21 @@ Optional properties:
 
 Example:
 
-ehrpwm0: ehrpwm at 0 { /* EHRPWM on am33xx */
+ehrpwm0: pwm at 48300200 { /* EHRPWM on am33xx */
 	compatible = "ti,am33xx-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x48300200 0x100>;
 	ti,hwmods = "ehrpwm0";
 };
 
-ehrpwm0: ehrpwm at 0 { /* EHRPWM on am4372 */
+ehrpwm0: pwm at 48300200 { /* EHRPWM on am4372 */
 	compatible = "ti,am4372-ehrpwm", "ti,am33xx-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x48300200 0x80>;
 	ti,hwmods = "ehrpwm0";
 };
 
-ehrpwm0: ehrpwm at 0 { /* EHRPWM on da850 */
+ehrpwm0: pwm at 1f00000 { /* EHRPWM on da850 */
 	compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x300000 0x2000>;
-- 
2.7.0
