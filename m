From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Nov 2011 14:33:39 +0000
Subject: [PATCH] ARM: S3C64XX: Add linux/export.h to dev-spi.c
Message-ID: <1322490819-18971-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required for the EXPORT_SYMBOL()s the code uses, previously the
header was being included implicitly by another header.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/dev-spi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
index 86fb130..3f437e7 100644
--- a/arch/arm/mach-s3c64xx/dev-spi.c
+++ b/arch/arm/mach-s3c64xx/dev-spi.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
-- 
1.7.7.3
