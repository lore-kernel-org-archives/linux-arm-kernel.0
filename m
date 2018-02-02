From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Feb 2018 16:39:24 +0100
Subject: [PATCH 1/2] i2c-nomadik: Delete an error message for a failed memory
 allocation in nmk_i2c_probe()
In-Reply-To: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
References: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
Message-ID: <9448237a-67cb-0e7c-0837-ad1b89fc41a1@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:25:14 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-nomadik.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 49c7c0c91486..a783ad25fe19 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -975,7 +975,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
-		dev_err(&adev->dev, "cannot allocate memory\n");
 		ret = -ENOMEM;
 		goto err_no_mem;
 	}
-- 
2.16.1
