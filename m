From: peterhuewe@gmx.de (Peter Huewe)
Date: Mon, 20 May 2013 22:22:04 +0200
Subject: [PATCH] arm/mach-u300/dummyspichip: Use module_spi_driver to register
 driver
Message-ID: <1369081324-8062-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing some boilerplate by using module_spi_driver instead of calling
register and unregister in the otherwise empty init/exit functions.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/arm/mach-u300/dummyspichip.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 2785cb6..aee609d 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -272,19 +272,7 @@ static struct spi_driver pl022_dummy_driver = {
 	.remove	= pl022_dummy_remove,
 };
 
-static int __init pl022_init_dummy(void)
-{
-	return spi_register_driver(&pl022_dummy_driver);
-}
-
-static void __exit pl022_exit_dummy(void)
-{
-	spi_unregister_driver(&pl022_dummy_driver);
-}
-
-module_init(pl022_init_dummy);
-module_exit(pl022_exit_dummy);
-
+module_spi_driver(pl022_dummy_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
 MODULE_DESCRIPTION("PL022 SSP/SPI DUMMY Linux driver");
 MODULE_LICENSE("GPL");
-- 
1.8.1.5
