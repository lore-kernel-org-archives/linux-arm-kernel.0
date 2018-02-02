From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Feb 2018 16:40:17 +0100
Subject: [PATCH 2/2] i2c-nomadik: Improve a size determination in
 nmk_i2c_probe()
In-Reply-To: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
References: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
Message-ID: <bca34c12-2139-586d-1e7b-87827dce7c58@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:28:20 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a783ad25fe19..e353b528140e 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -973,7 +973,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	struct i2c_vendor_data *vendor = id->data;
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
-	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&adev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto err_no_mem;
-- 
2.16.1
