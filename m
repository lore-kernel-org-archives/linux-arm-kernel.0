From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jan 2012 15:06:52 +0000
Subject: [PATCH] ARM: S3C64XX: Make s3c64xx_init_uarts() static
Message-ID: <1326812812-27194-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that it's in common.c it's not used in multiple source files.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 4a7394d..bee7dcd 100644
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
