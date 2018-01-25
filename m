From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Jan 2018 16:48:16 +0100
Subject: [PATCH 2/2] Input: sirfsoc-onkey: Improve a size determination in
 sirfsoc_pwrc_probe()
In-Reply-To: <b66f4105-57f2-adc2-ecde-cd4dacac408c@users.sourceforge.net>
References: <b66f4105-57f2-adc2-ecde-cd4dacac408c@users.sourceforge.net>
Message-ID: <07e55fcd-8ba5-bae4-0d05-34ada8453a47@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 16:35:13 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/sirfsoc-onkey.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 9d8b4e2d7063..cdad20811d35 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -111,8 +111,7 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	int irq;
 	int error;
 
-	pwrcdrv = devm_kzalloc(&pdev->dev, sizeof(struct sirfsoc_pwrc_drvdata),
-			       GFP_KERNEL);
+	pwrcdrv = devm_kzalloc(&pdev->dev, sizeof(*pwrcdrv), GFP_KERNEL);
 	if (!pwrcdrv)
 		return -ENOMEM;
 
-- 
2.16.1
