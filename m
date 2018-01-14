From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 14 Jan 2018 21:42:06 +0100
Subject: [PATCH 1/3] mfd/abx500-core: Delete an error message for a failed
 memory allocation in abx500_register_ops()
In-Reply-To: <d1862d7a-412e-9aaf-8200-bb2070ee402a@users.sourceforge.net>
References: <d1862d7a-412e-9aaf-8200-bb2070ee402a@users.sourceforge.net>
Message-ID: <f5fc286f-88c4-d857-33f7-de81076168ce@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jan 2018 21:08:27 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/abx500-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index 0d3846a4767c..c8c9d41abcaa 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -40,10 +40,9 @@ int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 	dev_entry = devm_kzalloc(dev,
 				 sizeof(struct abx500_device_entry),
 				 GFP_KERNEL);
-	if (!dev_entry) {
-		dev_err(dev, "register_ops kzalloc failed");
+	if (!dev_entry)
 		return -ENOMEM;
-	}
+
 	dev_entry->dev = dev;
 	memcpy(&dev_entry->ops, ops, sizeof(struct abx500_ops));
 
-- 
2.15.1
