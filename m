From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:05 +0200
Subject: [PATCH 30/39] ARM: u300 use module_spi_driver to register driver
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-31-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>

Removing some boilerplate by using module_spi_driver instead of calling
register and unregister in the otherwise empty init/exit functions.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/dummyspichip.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 52962bf..ec0283c 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -278,19 +278,7 @@ static struct spi_driver pl022_dummy_driver = {
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
1.7.11.3
