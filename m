From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 23 Jul 2013 20:01:39 +0200
Subject: [PATCH 06/27] drivers/i2c/busses: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1374602524-3398-7-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Please apply via the subsystem-tree.

 drivers/i2c/busses/i2c-stu300.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index d1a6b20..ded21cf 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -884,9 +884,6 @@ stu300_probe(struct platform_device *pdev)
 
 	dev->pdev = pdev;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-
 	dev->virtbase = devm_ioremap_resource(&pdev->dev, res);
 	dev_dbg(&pdev->dev, "initialize bus device I2C%d on virtual "
 		"base %p\n", bus_nr, dev->virtbase);
-- 
1.7.10.4
