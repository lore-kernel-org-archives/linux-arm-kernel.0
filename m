From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 16 Jul 2012 16:55:57 +0800
Subject: [PATCH] mfd: anatop: matches should be NULL when populate child
 devices
Message-ID: <1342428957-14321-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/mfd/anatop-mfd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/anatop-mfd.c b/drivers/mfd/anatop-mfd.c
index 6da0634..5576e07 100644
--- a/drivers/mfd/anatop-mfd.c
+++ b/drivers/mfd/anatop-mfd.c
@@ -83,7 +83,7 @@ static int __devinit of_anatop_probe(struct platform_device *pdev)
 	drvdata->ioreg = ioreg;
 	spin_lock_init(&drvdata->reglock);
 	platform_set_drvdata(pdev, drvdata);
-	of_platform_populate(np, of_anatop_match, NULL, dev);
+	of_platform_populate(np, NULL, NULL, dev);
 
 	return 0;
 }
-- 
1.7.9.5
