From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 26 Aug 2010 06:11:25 +0200
Subject: [PATCH] i2c-pxa: Squash warning about discarding qualifier
Message-ID: <1282795885-4445-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 020ff23..c94e51b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1001,7 +1001,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct pxa_i2c *i2c;
 	struct resource *res;
 	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
-	struct platform_device_id *id = platform_get_device_id(dev);
+	const struct platform_device_id *id = platform_get_device_id(dev);
 	int ret;
 	int irq;
 
-- 
1.7.1
