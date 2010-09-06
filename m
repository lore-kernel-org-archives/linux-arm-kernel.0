From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 6 Sep 2010 11:02:12 +0200
Subject: [PATCH] SPI: move PL022 probe call to subsys_initcall()
Message-ID: <1283763732-19419-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL022 SPI bus is sometimes used for early stuff like
regulators that need to be present at module_init() time, so
we move this to a subsys_initcall().

Cc: Lukasz Baj <lukasz.baj@tieto.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/spi/amba-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 3db5402..f958072 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -2324,7 +2324,7 @@ static int __init pl022_init(void)
 	return amba_driver_register(&pl022_driver);
 }
 
-module_init(pl022_init);
+subsys_initcall(pl022_init);
 
 static void __exit pl022_exit(void)
 {
-- 
1.6.3.3
