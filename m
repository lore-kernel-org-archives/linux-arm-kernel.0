From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:46 +0200
Subject: [PATCH 66/71] clocksource: sh_cmt: Remove unnecessary OOM messages
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-66-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingoo Han <jg1.han@samsung.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

[dlezcano] : refreshed against latest modifications: kmalloc -> kzalloc

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index bc8d025..dfa7803 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1106,10 +1106,8 @@ static int sh_cmt_probe(struct platform_device *pdev)
 	}
 
 	cmt = kzalloc(sizeof(*cmt), GFP_KERNEL);
-	if (cmt == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
+	if (cmt == NULL)
 		return -ENOMEM;
-	}
 
 	ret = sh_cmt_setup(cmt, pdev);
 	if (ret) {
-- 
1.7.9.5
