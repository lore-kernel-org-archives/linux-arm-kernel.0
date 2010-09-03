From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  3 Sep 2010 11:56:55 +0200
Subject: [PATCH 4/7] ARM: specify ZRELADDR for ARCH_LPC32XX
In-Reply-To: <20100903095504.GC13643@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
Message-ID: <1283507818-1573-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was missed in commit

	e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)

Cc: Kevin Wells <wellsk40@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                    |    4 +++-
 arch/arm/mach-lpc32xx/Makefile.boot |    1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c43b508..4a9a55c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1630,7 +1630,9 @@ config ZRELADDR
 	default 0x50008000 if ARCH_S3C64XX ||\
 		ARCH_SH7367
 	default 0x60008000 if ARCH_VEXPRESS
-	default 0x80008000 if ARCH_MX25 ||\
+	default 0x80008000 if \
+		ARCH_LPC32XX ||\
+		ARCH_MX25 ||\
 		ARCH_MX3 ||\
 		ARCH_NETX ||\
 		ARCH_OMAP2PLUS ||\
diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
index b796b41..e6bde79 100644
--- a/arch/arm/mach-lpc32xx/Makefile.boot
+++ b/arch/arm/mach-lpc32xx/Makefile.boot
@@ -1,4 +1,3 @@
-   zreladdr-y	:= 0x80008000
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x82000000
 
-- 
1.7.1
