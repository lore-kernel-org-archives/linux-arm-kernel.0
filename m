From: m.olbrich@pengutronix.de (Michael Olbrich)
Date: Fri, 18 Jul 2014 10:11:23 +0200
Subject: [PATCH] ARM: versatile: allow enabling PCI for device tree only
 kernels
Message-ID: <1405671083-18561-1-git-send-email-m.olbrich@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it possible to build a device tree only kernel with PCI support.
This is necessary to access the i6300esb watchdog provided by qemu.

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
---
 arch/arm/mach-versatile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index 1dba368..993ed4b 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -20,6 +20,7 @@ config MACH_VERSATILE_AB
 config MACH_VERSATILE_DT
 	bool "Support Versatile platform from device tree"
 	select CPU_ARM926T
+	select MIGHT_HAVE_PCI
 	select USE_OF
 	help
 	  Include support for the ARM(R) Versatile/PB platform,
-- 
2.0.1
