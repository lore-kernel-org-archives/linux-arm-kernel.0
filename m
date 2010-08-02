From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  2 Aug 2010 10:42:17 +0200
Subject: [PATCH] ARM: don't expose CONFIG_ZRELADDR to the users
In-Reply-To: <20100731155430.GG27064@n2100.arm.linux.org.uk>
References: <20100731155430.GG27064@n2100.arm.linux.org.uk>
Message-ID: <1280738537-12918-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This value is essential for booting a zImage and only depends on the
memory layout of the machine to boot.  This value was specified in
Makefile.boot before

	e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)

and so wasn't available to change via .config.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e39caa8..ec0e124 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1528,7 +1528,7 @@ config AUTO_ZRELADDR
 	  from start of memory.
 
 config ZRELADDR
-	hex "Physical address of the decompressed kernel image"
+	hex
 	depends on !AUTO_ZRELADDR
 	default 0x00008000 if ARCH_BCMRING ||\
 		ARCH_CNS3XXX ||\
-- 
1.7.1
