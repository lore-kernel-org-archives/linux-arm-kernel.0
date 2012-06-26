From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 16:58:08 +0800
Subject: [PATCH 1/4] pwm: pwm-mxs: encode soc name in compatible string
In-Reply-To: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
References: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340701091-8488-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Encode soc name in the compatible string to know the specific version
hardware block.  This is the general approach adopted for most bindings.
Change mxs-pwm binding to use the approach.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt |    4 ++--
 drivers/pwm/pwm-mxs.c                             |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
index 48ead0d..b16f4a5 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
@@ -1,7 +1,7 @@
 Freescale MXS PWM controller
 
 Required properties:
-- compatible: should be "fsl,mxs-pwm"
+- compatible: should be "fsl,imx23-pwm"
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2.  The first cell specifies the per-chip index
   of the PWM to use and the second cell is the duty cycle in nanoseconds.
@@ -10,7 +10,7 @@ Required properties:
 Example:
 
 pwm: pwm at 80064000 {
-	compatible = "fsl,imx28-pwm", "fsl,mxs-pwm";
+	compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
 	reg = <0x80064000 2000>;
 	#pwm-cells = <2>;
 	fsl,pwm-number = <8>;
diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index ebf91da..7af3a6a 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -186,7 +186,7 @@ static int __devexit mxs_pwm_remove(struct platform_device *pdev)
 }
 
 static struct of_device_id mxs_pwm_dt_ids[] = {
-	{ .compatible = "fsl,mxs-pwm", },
+	{ .compatible = "fsl,imx23-pwm", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_pwm_of_match);
-- 
1.7.5.4
