From: PeterHuewe@gmx.de (Peter =?iso-8859-1?q?H=FCwe?=)
Date: Mon, 18 Jan 2010 18:18:10 +0100
Subject: [PATCH] arch/arm: Fix build failure for ixp23xx-defconfig caused by
	typo
Message-ID: <201001181818.10397.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>
Date: Mon, 18 Jan 2010 18:07:20 +0100

This patch fixes a build failure[1] caused by an odd parenthesis.

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2020080/

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: 2.6.33-rc4

Checkpatch generates warnings for the patch - but this is due to the original code, not the change.

 arch/arm/mach-ixp23xx/include/mach/memory.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/include/mach/memory.h b/arch/arm/mach-ixp23xx/include/mach/memory.h
index 94a3a86..6ef65d8 100644
--- a/arch/arm/mach-ixp23xx/include/mach/memory.h
+++ b/arch/arm/mach-ixp23xx/include/mach/memory.h
@@ -19,7 +19,7 @@
  */
 #define PHYS_OFFSET		(0x00000000)
 
-#define IXP23XX_PCI_SDRAM_OFFSET (*((volatile int *)IXP23XX_PCI_SDRAM_BAR) & 0xfffffff0))
+#define IXP23XX_PCI_SDRAM_OFFSET (*((volatile int *)IXP23XX_PCI_SDRAM_BAR) & 0xfffffff0)
 
 #define __phys_to_bus(x)	((x) + (IXP23XX_PCI_SDRAM_OFFSET - PHYS_OFFSET))
 #define __bus_to_phys(x)	((x) - (IXP23XX_PCI_SDRAM_OFFSET - PHYS_OFFSET))
-- 
1.6.4.4
