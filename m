From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  3 Oct 2018 09:24:30 +0200
Subject: [PATCH v2] nvmem: lpc18xx_eeprom: remove unused variable
Message-ID: <20181003072430.20966-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a variable that's no longer used from lpc18xx_eeprom_remove().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
v1 -> v2:
- added the Reported-by tag

 drivers/nvmem/lpc18xx_eeprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index b42dbaddb419..66cff1e2147a 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
-	int ret;
 
 	clk_disable_unprepare(eeprom->clk);
 
-- 
2.19.0
