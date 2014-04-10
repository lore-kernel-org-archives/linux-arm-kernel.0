From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 16:19:29 +0200
Subject: [PATCH] i2c: nomadik: Don't use IS_ERR for devm_ioremap
Message-ID: <1397139569-3906-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap() returns NULL on error, not an error.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 28cbe1b..32c85e9 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -999,7 +999,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
 				resource_size(&adev->res));
-	if (IS_ERR(dev->virtbase)) {
+	if (!dev->virtbase) {
 		ret = -ENOMEM;
 		goto err_no_mem;
 	}
-- 
1.7.9.5
