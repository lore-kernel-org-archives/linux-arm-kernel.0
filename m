From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:23 +0100
Subject: [PATCH 26/62] ARM: mvebu: don't select CONFIG_NEON
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-27-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_NEON is meant to be user-selectable. Turning it on
unconditionally means we can't build a smaller kernel when
we don't need it, and causes build errors if CONFIG_VFP
is not also enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 485513cb..b24a082 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -39,7 +39,6 @@ config MACH_ARMADA_375
 	select ARMADA_375_CLK
 	select CPU_V7
 	select MACH_MVEBU_V7
-	select NEON
 	select PINCTRL_ARMADA_375
 	help
 	  Say 'Y' here if you want your kernel to support boards based
@@ -53,7 +52,6 @@ config MACH_ARMADA_38X
 	select ARMADA_38X_CLK
 	select CPU_V7
 	select MACH_MVEBU_V7
-	select NEON
 	select PINCTRL_ARMADA_38X
 	help
 	  Say 'Y' here if you want your kernel to support boards based
-- 
1.8.3.2
