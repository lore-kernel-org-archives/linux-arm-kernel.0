From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:19 +0000
Subject: [PATCH 22/46] regulator: ab8500-ext: Add support for AB8505/AB9540
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-23-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bengt Jonsson <bengt.g.jonsson@stericsson.com>

The external regulator driver checks for old AB8500 HW
to apply a fix. This patch adds a check to see that
it is a AB8500 (not AB8505/AB9540).

Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500-ext.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 3af40fd..f3ec867 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -386,7 +386,7 @@ int ab8500_ext_regulator_init(struct platform_device *pdev)
 	}
 
 	/* check for AB8500 2.x */
-	if (abx500_get_chip_id(&pdev->dev) < 0x30) {
+	if (is_ab8500_2p0_or_earlier(ab8500)) {
 		struct ab8500_ext_regulator_info *info;
 
 		/* VextSupply3LPn is inverted on AB8500 2.x */
-- 
1.7.10.4
