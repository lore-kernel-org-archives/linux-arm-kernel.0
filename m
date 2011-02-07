From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Mon,  7 Feb 2011 17:52:38 +0530
Subject: [PATCH] OMAP1: PM: fix omap1 build
Message-ID: <1297081358-8294-1-git-send-email-manjugk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap1_defconfig build on pm branch throughs below build error:

  CC      drivers/i2c/busses/i2c-omap.o
drivers/i2c/busses/i2c-omap.c:1173: error: lvalue required as unary '&' operand
make[3]: *** [drivers/i2c/busses/i2c-omap.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

Fix above build error. Boot tested on omap1710(h3) board.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0541df9..8db456f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1170,7 +1170,7 @@ static struct platform_driver omap_i2c_driver = {
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-		.pm     = &omap_i2c_pm_ops,
+		.pm     = omap_i2c_pm_ops,
 	},
 };
 
-- 
1.7.1
