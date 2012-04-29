From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sun, 29 Apr 2012 17:28:49 +0200
Subject: [PATCH 2/3] pwm-imx: set chip.dev to prevent probe failure
In-Reply-To: <1335713330-6488-1-git-send-email-eric@eukrea.com>
References: <1335713330-6488-1-git-send-email-eric@eukrea.com>
Message-ID: <1335713330-6488-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

else pwmchip_add fails

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/pwm/pwm-imx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index ef9c51b..d69275f 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -175,6 +175,7 @@ static int __devinit imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.ops = &imx_pwm_ops;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
+	imx->chip.dev = &pdev->dev;
 
 	imx->clk_enabled = 0;
 
-- 
1.7.7.6
