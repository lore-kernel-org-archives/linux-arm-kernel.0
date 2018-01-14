From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 14 Jan 2018 21:44:43 +0100
Subject: [PATCH 3/3] mfd/abx500-core: Adjust 14 checks for null pointers
In-Reply-To: <d1862d7a-412e-9aaf-8200-bb2070ee402a@users.sourceforge.net>
References: <d1862d7a-412e-9aaf-8200-bb2070ee402a@users.sourceforge.net>
Message-ID: <54712a5d-5874-c29a-40b4-5482ea06958c@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jan 2018 21:31:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script ?checkpatch.pl? pointed information out like the following.

Comparison to NULL could be written ?

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/abx500-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index 17176e91cbd0..f282d39a5917 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -65,7 +65,7 @@ int abx500_set_register_interruptible(struct device *dev, u8 bank, u8 reg,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->set_register != NULL))
+	if (ops && ops->set_register)
 		return ops->set_register(dev, bank, reg, value);
 	else
 		return -ENOTSUPP;
@@ -78,7 +78,7 @@ int abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->get_register != NULL))
+	if (ops && ops->get_register)
 		return ops->get_register(dev, bank, reg, value);
 	else
 		return -ENOTSUPP;
@@ -91,7 +91,7 @@ int abx500_get_register_page_interruptible(struct device *dev, u8 bank,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->get_register_page != NULL))
+	if (ops && ops->get_register_page)
 		return ops->get_register_page(dev, bank,
 			first_reg, regvals, numregs);
 	else
@@ -105,7 +105,7 @@ int abx500_mask_and_set_register_interruptible(struct device *dev, u8 bank,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->mask_and_set_register != NULL))
+	if (ops && ops->mask_and_set_register)
 		return ops->mask_and_set_register(dev, bank,
 			reg, bitmask, bitvalues);
 	else
@@ -118,7 +118,7 @@ int abx500_get_chip_id(struct device *dev)
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->get_chip_id != NULL))
+	if (ops && ops->get_chip_id)
 		return ops->get_chip_id(dev);
 	else
 		return -ENOTSUPP;
@@ -130,7 +130,7 @@ int abx500_event_registers_startup_state_get(struct device *dev, u8 *event)
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->event_registers_startup_state_get != NULL))
+	if (ops && ops->event_registers_startup_state_get)
 		return ops->event_registers_startup_state_get(dev, event);
 	else
 		return -ENOTSUPP;
@@ -142,7 +142,7 @@ int abx500_startup_irq_enabled(struct device *dev, unsigned int irq)
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->startup_irq_enabled != NULL))
+	if (ops && ops->startup_irq_enabled)
 		return ops->startup_irq_enabled(dev, irq);
 	else
 		return -ENOTSUPP;
-- 
2.15.1
