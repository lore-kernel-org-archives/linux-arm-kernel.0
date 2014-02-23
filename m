From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Sun, 23 Feb 2014 17:42:06 +0100
Subject: [PATCH] i2c: nomadik: Silence compiler warning
Message-ID: <1393173726-29479-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "i2c: nomadik: Fixup deployment of runtime PM" introduced a
compiler warning for !CONFIG_PM. Let's fix it here.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Wolfram, currently one of the queued patches for i2c nomadik introduced a
compiler warning. I decided to add a fixup patch on top of these instead of
you dropping them and me resending new versions of the already applied patches.

If you think it's better to drop the queued patches and to resend new verions,
please tell me.

---
 drivers/i2c/busses/i2c-nomadik.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 8082f5c..5f47454 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -895,7 +895,7 @@ static int nmk_i2c_resume_early(struct device *dev)
 }
 #endif
 
-#if CONFIG_PM
+#ifdef CONFIG_PM
 static int nmk_i2c_runtime_suspend(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
-- 
1.7.9.5
