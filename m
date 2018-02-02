From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Feb 2018 18:22:21 +0100
Subject: [PATCH 2/2] i2c-davinci: Improve a size determination in
 davinci_i2c_probe()
In-Reply-To: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
References: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Message-ID: <e16ba754-078a-097a-7333-076f43718645@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:02:49 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-davinci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 71a9c29b3981..1702b1d1b000 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -782,8 +782,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
-			GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.16.1
