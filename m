From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Dec 2011 01:13:14 +0000
Subject: [PATCH] ARM: S3C64XX: Staticise s3c64xx_init_uarts()
Message-ID: <1325121194-32240-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the merge of everything into common.c s3c64xx_init_uarts() is now
only used within the one source file and should therefore be declared
static.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 8ae5b16..f8cc5a0 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -49,7 +49,7 @@
 
 /* uart registration process */
 
-void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+static void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	s3c24xx_init_uartdevs("s3c6400-uart", s3c64xx_uart_resources, cfg, no);
 }
-- 
1.7.7.3
