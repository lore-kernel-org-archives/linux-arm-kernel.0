From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:54:17 +0100
Subject: [PATCH 09/10] ARM: io: remove IO_SPACE_LIMIT from platforms without
	PCI/ISA
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1Qtax7-0007ND-2P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing should be using PCI/ISA IO on these platforms, so their
IO_SPACE_LIMIT definitions are irrelevent.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/include/mach/io.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/include/mach/io.h b/arch/arm/mach-vexpress/include/mach/io.h
index 748bb52..13522d8 100644
--- a/arch/arm/mach-vexpress/include/mach/io.h
+++ b/arch/arm/mach-vexpress/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-- 
1.7.4.4
