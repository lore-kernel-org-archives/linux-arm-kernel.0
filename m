From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:47 +0200
Subject: [PATCH 67/71] clocksource: sh_mtu2: Remove unnecessary OOM messages
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-67-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingoo Han <jg1.han@samsung.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

[dlezcano] : refreshed against latest modifications: kmalloc -> kzalloc

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_mtu2.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index f2c1c36..188d4e0 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -533,10 +533,8 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 	}
 
 	mtu = kzalloc(sizeof(*mtu), GFP_KERNEL);
-	if (mtu == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
+	if (mtu == NULL)
 		return -ENOMEM;
-	}
 
 	ret = sh_mtu2_setup(mtu, pdev);
 	if (ret) {
-- 
1.7.9.5
