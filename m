From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 14:06:35 +0200
Subject: [PATCH] crypto: ux500: add missing comma
Message-ID: <1365163595-21926-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Commit 4f31f5b19eb0418a847b989abc9ac22af1991fe2
"PM / crypto / ux500: Use struct dev_pm_ops for power management"
add a new line to the driver struct but missed to add a
trailing comma, causing build errors when crypto is
selected. This adds the missing comma.

This was not noticed until now because the crypto block
is not in the ux500 defconfig. A separate patch will
be submitted to fix this.

Cc: <stable@vger.kernel.org> # 3.8.x
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Magnus Myrstedt <magnus.p.persson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 8bc5fef..22c9063 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1750,7 +1750,7 @@ static struct platform_driver cryp_driver = {
 	.shutdown = ux500_cryp_shutdown,
 	.driver = {
 		.owner = THIS_MODULE,
-		.name  = "cryp1"
+		.name  = "cryp1",
 		.pm    = &ux500_cryp_pm,
 	}
 };
-- 
1.7.11.3
