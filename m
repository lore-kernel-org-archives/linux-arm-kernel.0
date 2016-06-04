From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:09:58 +0300
Subject: [PATCH 06/22] pwm: clps711x: Changing the compatibility string to
 match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-7-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt | 5 ++---
 drivers/pwm/pwm-clps711x.c                                    | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt b/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt
index a183db4..c0b2028 100644
--- a/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt
@@ -1,15 +1,14 @@
 * Cirris Logic CLPS711X PWM controller
 
 Required properties:
-- compatible: Shall contain "cirrus,clps711x-pwm".
+- compatible: Shall contain "cirrus,ep7209-pwm".
 - reg: Physical base address and length of the controller's registers.
 - clocks: phandle + clock specifier pair of the PWM reference clock.
 - #pwm-cells: Should be 1. The cell specifies the index of the channel.
 
 Example:
 	pwm: pwm at 80000400 {
-		compatible = "cirrus,ep7312-pwm",
-			     "cirrus,clps711x-pwm";
+		compatible = "cirrus,ep7312-pwm", "cirrus,ep7209-pwm";
 		reg = <0x80000400 0x4>;
 		clocks = <&clks 8>;
 		#pwm-cells = <1>;
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 7d33542..26ec24e 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -155,7 +155,7 @@ static int clps711x_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
-	{ .compatible = "cirrus,clps711x-pwm", },
+	{ .compatible = "cirrus,ep7209-pwm", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clps711x_pwm_dt_ids);
-- 
2.4.9
