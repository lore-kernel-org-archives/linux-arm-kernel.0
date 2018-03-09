From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 9 Mar 2018 17:01:35 +0100
Subject: [PATCH v2 01/17 1/3] mfd: abx500-core: Delete an error message for a
 failed memory allocation in abx500_register_ops()
In-Reply-To: <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Message-ID: <4948c6d9-af42-8c95-af38-fc448a8e25a2@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 11:44:33 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

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
2.16.2
