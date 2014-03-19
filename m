From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:21 +0100
Subject: [PATCH 24/62] ARM: omap1: select I2C where needed for PMIC
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-25-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP H2, OSK and OSIRIS machines cannot build without
I2C and TPS65010 both enabled unconditionally.

In each case, failing to enable CONFIG_I2C results in a
build or link error, so most consistent solution is to
ensure that it is impossible to disable those options.

It would be nice to leave CONFIG_I2C as user-selectable,
but doing that properly would require more work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
---
 arch/arm/mach-omap1/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index cdd05f2..23ab1d5 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -44,6 +44,8 @@ config MACH_OMAP_INNOVATOR
 config MACH_OMAP_H2
 	bool "TI H2 Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
+	select TPS65010
+	select I2C
     	help
 	  TI OMAP 1610/1611B H2 board support. Say Y here if you have such
 	  a board.
@@ -64,6 +66,8 @@ config MACH_HERALD
 config MACH_OMAP_OSK
 	bool "TI OSK Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
+	select TPS65010
+	select I2C
     	help
 	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
           if you have such a board.
-- 
1.8.3.2
