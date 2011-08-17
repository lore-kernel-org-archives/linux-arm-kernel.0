From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:51:56 +0100
Subject: [PATCH 02/10] ARM: io: RiscPC: define io addresses relative to IO_BASE
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1Qtauq-0007Ml-BH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-rpc/include/mach/hardware.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
index dde6b3c..822b810 100644
--- a/arch/arm/mach-rpc/include/mach/hardware.h
+++ b/arch/arm/mach-rpc/include/mach/hardware.h
@@ -51,12 +51,12 @@
 /*
  * IO Addresses
  */
-#define VIDC_BASE		IOMEM(0xe0400000)
-#define EXPMASK_BASE		0xe0360000
-#define IOMD_BASE		IOMEM(0xe0200000)
-#define IOC_BASE		IOMEM(0xe0200000)
-#define PCIO_BASE		IOMEM(0xe0010000)
-#define FLOPPYDMA_BASE		IOMEM(0xe002a000)
+#define VIDC_BASE		(IO_BASE + 0x00400000)
+#define EXPMASK_BASE		(IO_BASE + 0x00360000)
+#define IOMD_BASE		(IO_BASE + 0x00200000)
+#define IOC_BASE		(IO_BASE + 0x00200000)
+#define FLOPPYDMA_BASE		(IO_BASE + 0x0002a000)
+#define PCIO_BASE		(IO_BASE + 0x00010000)
 
 #define vidc_writel(val)	__raw_writel(val, VIDC_BASE)
 
-- 
1.7.4.4
