From: avinashphilip@ti.com (Philip Avinash)
Date: Thu, 14 Mar 2013 16:02:38 +0530
Subject: [PATCH 3/3] pwm: pwm-tiehrpwm: Add device tree binding support for
 da850 SOC
In-Reply-To: <1363257158-11615-1-git-send-email-avinashphilip@ti.com>
References: <1363257158-11615-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1363257158-11615-4-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EHRPWM IP is used in da850 SOC's also. Hence adds EHRPWM device tree
binding support for da850.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
:100644 100644 4fc7079... 0442d65... M	Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
:100644 100644 8b4c86f... 6561ec2... M	drivers/pwm/pwm-tiehrpwm.c
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |    2 +-
 drivers/pwm/pwm-tiehrpwm.c                         |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 4fc7079..0442d65 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -1,7 +1,7 @@
 TI SOC EHRPWM based PWM controller
 
 Required properties:
-- compatible : Must be "ti,am33xx-ehrpwm"
+- compatible : Must be "ti,am33xx-ehrpwm" or "ti,da850-ehrpwm"
 - #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
   First cell specifies the per-chip index of the PWM to use, the second
   cell is the period in nanoseconds and bit 0 in the third cell is used to
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 8b4c86f..6561ec2 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -428,6 +428,7 @@ static const struct pwm_ops ehrpwm_pwm_ops = {
 
 static const struct of_device_id ehrpwm_of_match[] = {
 	{ .compatible	= "ti,am33xx-ehrpwm" },
+	{ .compatible	= "ti,da850-ehrpwm" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ehrpwm_of_match);
-- 
1.7.9.5
