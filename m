From: robherring2@gmail.com (Rob Herring)
Date: Fri,  9 Dec 2011 16:56:08 -0600
Subject: [PATCH] gpio: pl061: drop extra check for NULL platform_data
Message-ID: <1323471368-7955-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In adding DT binding support, the check for NULL platform_data got added
back in inadvertently, so remove it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Linus or Grant, 

Can you apply this fix for 3.2-rc.

Thanks,
Rob

 drivers/gpio/gpio-pl061.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 093c90b..4102f63 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -238,10 +238,6 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
 	int ret, irq, i;
 	static DECLARE_BITMAP(init_irq, NR_IRQS);
 
-	pdata = dev->dev.platform_data;
-	if (pdata == NULL)
-		return -ENODEV;
-
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
-- 
1.7.5.4
