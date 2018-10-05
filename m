From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Fri, 5 Oct 2018 09:03:13 +0200
Subject: [PATCH] nvmem: lpc18xx_eeprom: fix compile warning
Message-ID: <20181005070313.GA2217@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning by removing unused variable ret:

drivers/nvmem/lpc18xx_eeprom.c: In function ?lpc18xx_eeprom_remove?:
drivers/nvmem/lpc18xx_eeprom.c:258:6: warning: unused variable ?ret?
[-Wunused-variable]
  int ret;
      ^~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/nvmem/lpc18xx_eeprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index b42dbad..66cff1e 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
-	int ret;
 
 	clk_disable_unprepare(eeprom->clk);
 
-- 
2.7.4
