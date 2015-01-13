From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 14:25:19 +0100
Subject: [PATCH 1/2] dmaengine: mmp-tdma: don't include mach/regs-icu.h
Message-ID: <2099590.pAO9NcseBT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmp tdma driver does not actually require this header, and
we want to enable multiplatform support for MMP, which would
make it inaccessible and cause a build error.

This patch just removes the old #include.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index a8a79b1763d5..91fb241102f7 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -19,7 +19,6 @@
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
-#include <mach/regs-icu.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
