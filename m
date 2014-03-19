From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:27 +0100
Subject: [PATCH 30/62] ARM: pxa: enable pxafb unconditionally for some boards
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-31-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SAAR and TAVOREVB machines try to call functions from
the PXAFB frame buffer driver from their platform code,
which only works if that driver is built-in.

This patch ensures that both the generic frame buffer
code and the specific pxafb driver are always enabled
when we build a kernel for one of the two boards.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 2c7498a..50f6132 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -53,12 +53,16 @@ config MACH_TAVOREVB
 	select CPU_PXA930
 	select CPU_PXA935
 	select PXA3xx
+	select FB
+	select FB_PXA
 
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
 	select CPU_PXA930
 	select CPU_PXA935
 	select PXA3xx
+	select FB
+	select FB_PXA
 
 comment "Third Party Dev Platforms (sorted by vendor name)"
 
-- 
1.8.3.2
