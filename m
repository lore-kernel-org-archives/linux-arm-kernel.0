From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:48 +0200
Subject: [PATCH 68/71] clocksource: sh_tmu: Remove unnecessary OOM messages
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-68-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingoo Han <jg1.han@samsung.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

[dlezcano] : refreshed against latest modifications: kmalloc -> kzalloc

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_tmu.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 4ba2c0f..a38022f 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -644,10 +644,8 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	}
 
 	tmu = kzalloc(sizeof(*tmu), GFP_KERNEL);
-	if (tmu == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
+	if (tmu == NULL)
 		return -ENOMEM;
-	}
 
 	ret = sh_tmu_setup(tmu, pdev);
 	if (ret) {
-- 
1.7.9.5
