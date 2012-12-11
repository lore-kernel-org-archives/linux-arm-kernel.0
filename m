From: dromede@gmail.com (dromede at gmail.com)
Date: Tue, 11 Dec 2012 20:40:11 +0100
Subject: [PATCH] [ARM] spitz/pxa: Minor naming fixes in spitz.c
Message-ID: <1355254812-14500-1-git-send-email-dromede@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede.gmail.com>

The NAND init section was erroneously named "Framebuffer".
Gpio expander section should really be called "I2C devices"
since it contains all i2c init code.

Signed-off-by: Marko Katic <dromede@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 2073f0e..0cc9dc7 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -732,7 +732,7 @@ static inline void spitz_lcd_init(void) {}
 #endif
 
 /******************************************************************************
- * Framebuffer
+ * NAND Flash
  ******************************************************************************/
 #if defined(CONFIG_MTD_NAND_SHARPSL) || defined(CONFIG_MTD_NAND_SHARPSL_MODULE)
 static struct mtd_partition spitz_nand_partitions[] = {
@@ -858,7 +858,7 @@ static inline void spitz_nor_init(void) {}
 #endif
 
 /******************************************************************************
- * GPIO expander
+ * I2C devices
  ******************************************************************************/
 #if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
 static struct pca953x_platform_data akita_pca953x_pdata = {
-- 
1.7.10.4
