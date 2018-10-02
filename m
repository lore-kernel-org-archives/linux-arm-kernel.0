From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  2 Oct 2018 23:10:01 +0200
Subject: [PATCH] nvmem: lpc18xx_eeprom: remove an unused variable
Message-ID: <20181002211016.2638186-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/nvmem/lpc18xx_eeprom.c: In function 'lpc18xx_eeprom_remove':
drivers/nvmem/lpc18xx_eeprom.c:258:6: error: unused variable 'ret' [-Werror=unused-variable]

Fixes: 226014d13fa5 ("nvmem: lpc18xx_eeprom: use devm_nvmem_register()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
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
2.18.0
