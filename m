From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed,  5 Dec 2012 16:34:41 +0100
Subject: [PATCH] pwm: i.MX: eliminate build warning
Message-ID: <1354721681-31843-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compiling the i.MX pwm driver produces the following warning:
|drivers/pwm/pwm-imx.c: In function 'imx_pwm_probe':
|drivers/pwm/pwm-imx.c:281:7: warning: assignment discards qualifiers from pointer target type

Apply a 'const' attribute to the affected variable declaration.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/pwm/pwm-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 8f26e9f..65a86bd 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -235,7 +235,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(imx_pwm_dt_ids, &pdev->dev);
-	struct imx_pwm_data *data;
+	const struct imx_pwm_data *data;
 	struct imx_chip *imx;
 	struct resource *r;
 	int ret = 0;
-- 
1.7.2.5
