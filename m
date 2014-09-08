From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 17:00:49 +0200
Subject: [PATCH] ARM: omap: fix Kconfig warning
Message-ID: <3763111.OttSKCMuxb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A small mistake during the recent Kconfig cleanup has led
to a harmless warning for OMAP1:

warning: (ARCH_OMAP1) selects ARCH_OMAP which has unmet direct dependencies (ARCH_MULTI_V6 || ARCH_MULTI_V7)

We can easily avoid that by moving the ARCH_OMAP symbol outside of the
OMAP2 submenu.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e7189dcc9309..30d787e99e1a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,9 +1,9 @@
-menu "TI OMAP/AM/DM/DRA Family"
-	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
-
 config ARCH_OMAP
 	bool
 
+menu "TI OMAP/AM/DM/DRA Family"
+	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
+
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_MULTI_V6
