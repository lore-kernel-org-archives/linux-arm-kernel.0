From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Feb 2018 18:21:21 +0100
Subject: [PATCH 1/2] i2c-davinci: Delete an error message for a failed memory
 allocation in davinci_i2c_probe()
In-Reply-To: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
References: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Message-ID: <f890924b-ca68-253b-a7c8-fce269393867@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:00:20 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index cb24a3ffdfa2..71a9c29b3981 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -784,10 +784,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
 			GFP_KERNEL);
-	if (!dev) {
-		dev_err(&pdev->dev, "Memory allocation failed\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	init_completion(&dev->cmd_complete);
 #ifdef CONFIG_CPU_FREQ
-- 
2.16.1
