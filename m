From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Jan 2018 16:46:56 +0100
Subject: [PATCH 1/2] Input: sirfsoc-onkey: Delete an error message for a
 failed memory allocation in sirfsoc_pwrc_probe()
In-Reply-To: <b66f4105-57f2-adc2-ecde-cd4dacac408c@users.sourceforge.net>
References: <b66f4105-57f2-adc2-ecde-cd4dacac408c@users.sourceforge.net>
Message-ID: <00544fed-52b0-0536-ad4e-f023668f08dd@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 16:32:09 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/sirfsoc-onkey.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4fd038d476a3..9d8b4e2d7063 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -113,10 +113,8 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 	pwrcdrv = devm_kzalloc(&pdev->dev, sizeof(struct sirfsoc_pwrc_drvdata),
 			       GFP_KERNEL);
-	if (!pwrcdrv) {
-		dev_info(&pdev->dev, "Not enough memory for the device data\n");
+	if (!pwrcdrv)
 		return -ENOMEM;
-	}
 
 	/*
 	 * We can't use of_iomap because pwrc is not mapped in memory,
-- 
2.16.1
