From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:53:56 +0100
Subject: [PATCH 08/10] ARM: io: remove IO_SPACE_LIMIT from platforms with
	ISA/PCI and 64K window
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1Qtawm-0007N9-VA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove IO_SPACE_LIMIT definitions from platforms which have a well
defined ISA or PCI, and has a 64K window.

EBSA110 - well defined set of ISA devices.
Footbridge, Integrator, IXP4xx, VT8500 - PCI platforms.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ebsa110/include/mach/io.h    |    2 --
 arch/arm/mach-footbridge/include/mach/io.h |    2 --
 arch/arm/mach-integrator/include/mach/io.h |    2 --
 arch/arm/mach-ixp4xx/include/mach/io.h     |    2 --
 arch/arm/mach-vt8500/include/mach/io.h     |    2 --
 5 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ebsa110/include/mach/io.h b/arch/arm/mach-ebsa110/include/mach/io.h
index f68daa63..44679db 100644
--- a/arch/arm/mach-ebsa110/include/mach/io.h
+++ b/arch/arm/mach-ebsa110/include/mach/io.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffff
-
 u8 __inb8(unsigned int port);
 void __outb8(u8  val, unsigned int port);
 
diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
index 32e4cc3..15a7039 100644
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ b/arch/arm/mach-footbridge/include/mach/io.h
@@ -23,8 +23,6 @@
 #define PCIO_SIZE       0x00100000
 #define PCIO_BASE       MMU_IO(0xff000000, 0x7c000000)
 
-#define IO_SPACE_LIMIT 0xffff
-
 /*
  * Translation of various region addresses to virtual addresses
  */
diff --git a/arch/arm/mach-integrator/include/mach/io.h b/arch/arm/mach-integrator/include/mach/io.h
index f21bb54..37beed3 100644
--- a/arch/arm/mach-integrator/include/mach/io.h
+++ b/arch/arm/mach-integrator/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffff
-
 /*
  * WARNING: this has to mirror definitions in platform.h
  */
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 57b5410..ffb9d6a 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -17,8 +17,6 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT 0x0000ffff
-
 extern int (*ixp4xx_pci_read)(u32 addr, u32 cmd, u32* data);
 extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
 
diff --git a/arch/arm/mach-vt8500/include/mach/io.h b/arch/arm/mach-vt8500/include/mach/io.h
index 9077239..46181ee 100644
--- a/arch/arm/mach-vt8500/include/mach/io.h
+++ b/arch/arm/mach-vt8500/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffff
-
 #define __io(a)		__typesafe_io((a) + 0xf0000000)
 #define __mem_pci(a)	(a)
 
-- 
1.7.4.4
