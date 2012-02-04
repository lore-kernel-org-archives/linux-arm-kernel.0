From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Feb 2012 10:50:13 +0000
Subject: [PATCH] Versatile Express: add NO_IOPORT
Message-ID: <20120204105013.GR889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Versatile Express, the PCI Express buses are broken and unusable, so
we aren't going to support PCI/ISA IO cycles on this platform.  Remove
the PCI/ISA IO inb et.al. support for this platform.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-vexpress/include/mach/io.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cd8f520..2323311 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -313,6 +313,7 @@ config ARCH_VEXPRESS
 	select HAVE_CLK
 	select HAVE_PATA_PLATFORM
 	select ICST
+	select NO_IOPORT
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
 	help
diff --git a/arch/arm/mach-vexpress/include/mach/io.h b/arch/arm/mach-vexpress/include/mach/io.h
index 13522d8..5e6b647 100644
--- a/arch/arm/mach-vexpress/include/mach/io.h
+++ b/arch/arm/mach-vexpress/include/mach/io.h
@@ -20,7 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
 #endif
