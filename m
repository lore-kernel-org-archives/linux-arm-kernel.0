From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:48 +0200
Subject: [PATCH 13/16] arm/mx3/qong: get rid of nearly empty header
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-13-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

board-qong.h only defined a single symbol that was used only once.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-qong.c               |    3 +--
 arch/arm/plat-mxc/include/mach/board-qong.h |   17 -----------------
 2 files changed, 1 insertions(+), 19 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-qong.h

diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index e5b5b83..62281ad 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -34,7 +34,6 @@
 #include <mach/common.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-#include <mach/board-qong.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include "devices.h"
@@ -116,7 +115,7 @@ static struct physmap_flash_data qong_flash_data = {
 
 static struct resource qong_flash_resource = {
 	.start = MX31_CS0_BASE_ADDR,
-	.end = MX31_CS0_BASE_ADDR + QONG_NOR_SIZE - 1,
+	.end = MX31_CS0_BASE_ADDR + SZ_128M - 1,
 	.flags = IORESOURCE_MEM,
 };
 
diff --git a/arch/arm/plat-mxc/include/mach/board-qong.h b/arch/arm/plat-mxc/include/mach/board-qong.h
deleted file mode 100644
index 6d88c7a..0000000
--- a/arch/arm/plat-mxc/include/mach/board-qong.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, <yanok@emcraft.com>
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_QONG_H__
-#define __ASM_ARCH_MXC_BOARD_QONG_H__
-
-/* NOR FLASH */
-#define QONG_NOR_SIZE		(128*1024*1024)
-
-#endif /* __ASM_ARCH_MXC_BOARD_QONG_H__ */
-- 
1.7.0
