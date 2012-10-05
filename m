From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 5 Oct 2012 17:51:11 +0200
Subject: [PATCH 1/2] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
Message-ID: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This reverts commit 6887237cd7da904184dab2750504040c68f3a080.

Commit "spi/pl022: enable runtime PM" introduced runtime PM issues.
Due to that commit, "spi/pl022: fix spi-pl022 pm enable at probe"
was merged to fix part of those issues.

Instead of adding another fix, let's clean up and revert everything
back to when it was already fine.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 9194641..5cf0643 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2186,6 +2186,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
 
+	pm_runtime_enable(dev);
 	pm_runtime_resume(dev);
 
 	pl022->clk = devm_clk_get(&adev->dev, NULL);
-- 
1.7.10
