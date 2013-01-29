From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 29 Jan 2013 21:23:07 +0800
Subject: [PATCH] ARM:common: deleting waste code which never execute
Message-ID: <5107CD3B.4080600@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  delete the waste code which never execute

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/common/scoop.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index a5c3dc3..6ef146e 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -232,8 +232,6 @@ static int scoop_probe(struct platform_device *pdev)

 	return 0;

-	if (devptr->gpio.base != -1)
-		temp = gpiochip_remove(&devptr->gpio);
 err_gpio:
 	platform_set_drvdata(pdev, NULL);
 err_ioremap:
-- 
1.7.10.4
