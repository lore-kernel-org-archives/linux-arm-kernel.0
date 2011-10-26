From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson XK)
Date: Wed, 26 Oct 2011 10:49:35 +0200
Subject: [PATCH 2/2] ARM: ux500: Support SD cards on HREFv60 boards
Message-ID: <1319618975-17044-1-git-send-email-stefan.xk.nilsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Properly support the correct SDI-init sequence on the
ST-Ericsson HREFv60 and later boards in order to get
support for SD cards.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 +-
 arch/arm/mach-ux500/board-mop500.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4d75b0d..a4d8136 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -671,7 +671,7 @@ static void __init hrefv60_init_machine(void)
 			ARRAY_SIZE(mop500_platform_devs));
 
 	mop500_i2c_init();
-	mop500_sdi_init();
+	hrefv60_sdi_init();
 	mop500_spi_init();
 	mop500_uart_init();
 
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index de18a2a..e82552a 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -41,6 +41,7 @@ struct i2c_board_info;
 
 extern void mop500_sdi_init(void);
 extern void snowball_sdi_init(void);
+extern void hrefv60_sdi_init(void);
 extern void mop500_sdi_tc35892_init(void);
 void __init mop500_u8500uib_init(void);
 void __init mop500_stuib_init(void);
-- 
1.7.7
