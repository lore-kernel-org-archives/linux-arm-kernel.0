From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 18:45:50 +0900
Subject: [PATCH] ARM: shmobile: marzen: Include mmc/host.h
Message-ID: <1360748750-11911-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc/host.h provides MMC_CAP_SD_HIGHSPEED which is used in board-marzen.c

This resolves a build problem observed when compiling with
"mmc: tmio: remove unused and deprecated symbols" applied.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 0020506..3b3554a 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -32,6 +32,7 @@
 #include <linux/smsc911x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/sh_hspi.h>
+#include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/usb/otg.h>
-- 
1.7.10.4
