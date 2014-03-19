From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:32 +0100
Subject: [PATCH 35/62] ARM: pxa: trizeps4 and trizeps4wl use the same file
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-36-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trizeps4 and trizeps4wl platforms are both implemented
using the same board file. Since the trizeps4wl code is a
superset of trizeps4, it makes no sense to enable just the
latter, but with the current Kconfig logic, it causes the
board file not to be built at all.

Selecting MACH_TRIZEPS4 from MACH_TRIZEPS4WL ensures that
we are actually building the board file.

Found during randconfig testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 8d9f4f1..692aa5c 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -183,6 +183,7 @@ config MACH_TRIZEPS4
 config MACH_TRIZEPS4WL
 	bool "Keith und Koep Trizeps4-WL DIMM-Module"
 	depends on TRIZEPS_PXA
+	select MACH_TRIZEPS4
 	select PXA27x
 	select TRIZEPS_PCMCIA
 
-- 
1.8.3.2
