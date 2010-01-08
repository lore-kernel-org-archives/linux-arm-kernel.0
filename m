From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:30 +0100
Subject: [PATCH 23/25] imx: remove unneeded include of mach/hardware.h
In-Reply-To: <1262967452-24353-22-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-22-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-23-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This include isn't needed and hurts when defining static inline
functions in mach/hardware.h (or files included by mach/hardware.h).

The reason is that the consumers of mach/uncompress.h are compiled using
-Dstatic= so the code for all inline function is included in e.g.
arch/arm/boot/compressed/misc.o.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: J?rg Knobloch <knobloch@incostartec.com>
Cc: Alan Carvalho de Assis <acassis@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: Dmitriy Taychenachev <dimichxp@gmail.com>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 4d5d395..d189f00 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -1,8 +1,6 @@
 /*
  *  arch/arm/plat-mxc/include/mach/uncompress.h
  *
- *
- *
  *  Copyright (C) 1999 ARM Limited
  *  Copyright (C) Shane Nay (shane at minirl.com)
  *
@@ -25,7 +23,6 @@
 
 #define __MXC_BOOT_UNCOMPRESS
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 
 static unsigned long uart_base;
-- 
1.6.5.2
