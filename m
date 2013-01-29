From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 29 Jan 2013 21:32:09 +0800
Subject: [PATCH v2] ARM:common: deleting waste code which never execute
Message-ID: <5107CF59.5060704@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  deleting waste code which never execute

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/common/scoop.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index a5c3dc3..a20fa80 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -182,7 +182,6 @@ static int scoop_probe(struct platform_device *pdev)
 	struct scoop_config *inf;
 	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int ret;
-	int temp;

 	if (!mem)
 		return -EINVAL;
@@ -232,8 +231,6 @@ static int scoop_probe(struct platform_device *pdev)

 	return 0;

-	if (devptr->gpio.base != -1)
-		temp = gpiochip_remove(&devptr->gpio);
 err_gpio:
 	platform_set_drvdata(pdev, NULL);
 err_ioremap:
-- 
1.7.10.4
