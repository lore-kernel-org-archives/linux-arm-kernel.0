From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 29 Jul 2010 13:46:30 +0800
Subject: [ARM] Remove useless PCIO_BASE definitions
Message-ID: <AANLkTi=jRFPLvcD4ZfSgGy57C7nBg7OSBHjx5H1E-fV=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    [ARM] Remove useless PCIO_BASE definitions

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h
b/arch/arm/mach-clps711x/include/mach/hardware.h
index b3ebe9e..d0b7d87 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -69,13 +69,6 @@
 #define SYSPLD_VIRT_BASE	0xfe000000
 #define SYSPLD_BASE		SYSPLD_VIRT_BASE

-#ifndef __ASSEMBLER__
-
-#define PCIO_BASE		IO_BASE
-
-#endif
-
-
 #if  defined (CONFIG_ARCH_AUTCPU12)

 #define  CS89712_VIRT_BASE	CLPS7111_VIRT_BASE
diff --git a/arch/arm/mach-h720x/include/mach/hardware.h
b/arch/arm/mach-h720x/include/mach/hardware.h
index 6c19156..c55a52c 100644
--- a/arch/arm/mach-h720x/include/mach/hardware.h
+++ b/arch/arm/mach-h720x/include/mach/hardware.h
@@ -182,8 +182,6 @@
 #define SERIAL_ENABLE_EN	(1<<0)

 /* General defines to pacify gcc */
-#define PCIO_BASE 		(0)	/* for inb, outb and friends */
-#define PCIO_VIRT		PCIO_BASE

 #define __ASM_ARCH_HARDWARE_INCMACH_H
 #include "boards.h"
diff --git a/arch/arm/mach-integrator/include/mach/hardware.h
b/arch/arm/mach-integrator/include/mach/hardware.h
index 8e26360..57f51ba 100644
--- a/arch/arm/mach-integrator/include/mach/hardware.h
+++ b/arch/arm/mach-integrator/include/mach/hardware.h
@@ -32,7 +32,6 @@
 #define IO_SIZE			0x0B000000                 // How much?
 #define IO_START		INTEGRATOR_HDR_BASE        // PA of IO

-#define PCIO_BASE		PCI_IO_VADDR
 #define PCIMEM_BASE		PCI_MEMORY_VADDR

 #define pcibios_assign_all_busses()	1
diff --git a/arch/arm/mach-ixp23xx/include/mach/hardware.h
b/arch/arm/mach-ixp23xx/include/mach/hardware.h
index c319200..57b508b 100644
--- a/arch/arm/mach-ixp23xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp23xx/include/mach/hardware.h
@@ -15,7 +15,6 @@
 #define __ASM_ARCH_HARDWARE_H

 /* PCI IO info */
-#define PCIO_BASE		IXP23XX_PCI_IO_VIRT
 #define PCIBIOS_MIN_IO		0x00000000
 #define PCIBIOS_MIN_MEM		0xe0000000

diff --git a/arch/arm/mach-l7200/include/mach/hardware.h
b/arch/arm/mach-l7200/include/mach/hardware.h
index c31909c..1ea24f1 100644
--- a/arch/arm/mach-l7200/include/mach/hardware.h
+++ b/arch/arm/mach-l7200/include/mach/hardware.h
@@ -52,6 +52,4 @@
 #define ISA_SIZE		0x20000000
 #define ISA_BASE		0xe0000000

-#define PCIO_BASE		IO_BASE
-
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
b/arch/arm/mach-pxa/include/mach/hardware.h
index 3d8d8cb..7f64d24 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -14,11 +14,6 @@
 #define __ASM_ARCH_HARDWARE_H

 /*
- * We requires absolute addresses.
- */
-#define PCIO_BASE		0
-
-/*
  * Workarounds for@least 2 errata so far require this.
  * The mapping is set in mach-pxa/generic.c.
  */
