From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  5 Sep 2012 10:40:50 +0200
Subject: [PATCH 1/8] gpio: 74x164: Use module_spi_driver boiler plate function
Message-ID: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpio/gpio-74x164.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index a31ad6f..2975036 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -159,18 +159,7 @@ static struct spi_driver gen_74x164_driver = {
 	.probe		= gen_74x164_probe,
 	.remove		= __devexit_p(gen_74x164_remove),
 };
-
-static int __init gen_74x164_init(void)
-{
-	return spi_register_driver(&gen_74x164_driver);
-}
-subsys_initcall(gen_74x164_init);
-
-static void __exit gen_74x164_exit(void)
-{
-	spi_unregister_driver(&gen_74x164_driver);
-}
-module_exit(gen_74x164_exit);
+module_spi_driver(gen_74x164_driver);
 
 MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
 MODULE_AUTHOR("Miguel Gaio <miguel.gaio@efixo.com>");
-- 
1.7.9.5
