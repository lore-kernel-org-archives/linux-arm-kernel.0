From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 17 Feb 2014 16:20:29 +0100
Subject: [PATCH V3 12/17] i2c: nomadik: Remove redundant call to
 pm_runtime_disable
Message-ID: <1392650429-14855-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The amba bus are responsible for pm_runtime_enable|disable, remove the
redundant pm_runtime_disable at driver removal.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index cd15c03..5fdfc97 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1079,7 +1079,6 @@ static int nmk_i2c_remove(struct amba_device *adev)
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-	pm_runtime_disable(&adev->dev);
 
 	return 0;
 }
-- 
1.7.9.5
