From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 11 Sep 2013 13:16:25 -0300
Subject: [PATCH] mtd: nand: pxa3xx: Add pxa3xx_nand_get_variant() stub for
 !CONFIG_OF
Message-ID: <1378916185-19738-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a dummy pxa3xx_nand_get_variant() stub, to fix
this build error (with pxa3xx_defconfig or similar):

drivers/mtd/nand/pxa3xx_nand.c:1325:2: error: implicit declaration of
function 'pxa3xx_nand_get_variant' [-Werror=implicit-function-declaration]

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 5db900d..240a239 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1289,6 +1289,12 @@ static inline int pxa3xx_nand_probe_dt(struct platform_device *pdev)
 {
 	return 0;
 }
+
+static inline enum pxa3xx_nand_variant
+pxa3xx_nand_get_variant(struct platform_device *pdev)
+{
+	return PXA3XX_NAND_VARIANT_PXA;
+}
 #endif
 
 static int pxa3xx_nand_probe(struct platform_device *pdev)
-- 
1.8.1.5
