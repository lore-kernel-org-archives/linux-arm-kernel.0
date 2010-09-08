From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  8 Sep 2010 11:25:38 +0100
Subject: [PATCH 1/2] ARM: S3C64XX: Fix dev-spi build
Message-ID: <1283941539-3892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irqs.h usage here got missed in the Samsung platform reorganisation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 arch/arm/mach-s3c64xx/dev-spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
index a492b98..bfa3ef7 100644
--- a/arch/arm/mach-s3c64xx/dev-spi.c
+++ b/arch/arm/mach-s3c64xx/dev-spi.c
@@ -18,10 +18,10 @@
 #include <mach/map.h>
 #include <mach/gpio-bank-c.h>
 #include <mach/spi-clocks.h>
+#include <mach/irqs.h>
 
 #include <plat/s3c64xx-spi.h>
 #include <plat/gpio-cfg.h>
-#include <plat/irqs.h>
 
 static char *spi_src_clks[] = {
 	[S3C64XX_SPI_SRCCLK_PCLK] = "pclk",
-- 
1.7.1
