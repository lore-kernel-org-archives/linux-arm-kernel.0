From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Jun 2012 21:36:05 +0800
Subject: [PATCH v2 2/4] pwm: pwm-mxs: use global reset function
 stmp_reset_block
In-Reply-To: <1340701091-8488-3-git-send-email-shawn.guo@linaro.org>
References: <1340701091-8488-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340804165-29331-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use global reset function stmp_reset_block instead of mxs_reset_block
to remove <mach/common.h> inclusion.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
* Select STMP_DEVICE for PWM_MXS Kconfig option

 drivers/pwm/Kconfig   |    1 +
 drivers/pwm/pwm-mxs.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 39bdebc..5227415 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -30,6 +30,7 @@ config PWM_IMX
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS && OF
+	select STMP_DEVICE
 	help
 	  Generic PWM framework driver for Freescale MXS.
 
diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 7af3a6a..7a97997 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
-#include <mach/common.h>
+#include <linux/stmp_device.h>
 
 #define SET	0x4
 #define CLR	0x8
@@ -163,7 +163,7 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	mxs->dev = &pdev->dev;
 	platform_set_drvdata(pdev, mxs);
 
-	mxs_reset_block(mxs->base);
+	stmp_reset_block(mxs->base);
 
 	return 0;
 
-- 
1.7.5.4
