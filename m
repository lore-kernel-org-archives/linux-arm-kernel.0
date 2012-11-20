From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:00:57 +0100
Subject: [PATCH 06/16] ARM: gic: move register definitions into .c file
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

There's only 1 user of gic registers outside of gic.c, so move the
register definitions into gic.c. For now, keep GIC_DIST_CNT as Tegra
uses it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/common/gic.c               |   21 ++++++++++++++++++++-
 arch/arm/include/asm/hardware/gic.h |   18 ------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index aa52699..55ea0d7 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -43,7 +43,26 @@
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/irq.h>
-#include <asm/hardware/gic.h>
+
+#define GIC_CPU_CTRL			0x00
+#define GIC_CPU_PRIMASK			0x04
+#define GIC_CPU_BINPOINT		0x08
+#define GIC_CPU_INTACK			0x0c
+#define GIC_CPU_EOI			0x10
+#define GIC_CPU_RUNNINGPRI		0x14
+#define GIC_CPU_HIGHPRI			0x18
+
+#define GIC_DIST_CTRL			0x000
+#define GIC_DIST_CTR			0x004
+#define GIC_DIST_ENABLE_SET		0x100
+#define GIC_DIST_ENABLE_CLEAR		0x180
+#define GIC_DIST_PENDING_SET		0x200
+#define GIC_DIST_PENDING_CLEAR		0x280
+#define GIC_DIST_ACTIVE_BIT		0x300
+#define GIC_DIST_PRI			0x400
+#define GIC_DIST_TARGET			0x800
+#define GIC_DIST_CONFIG			0xc00
+#define GIC_DIST_SOFTINT		0xf00
 
 union gic_base {
 	void __iomem *common_base;
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 4b1ce6c..8073dce 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -12,25 +12,7 @@
 
 #include <linux/compiler.h>
 
-#define GIC_CPU_CTRL			0x00
-#define GIC_CPU_PRIMASK			0x04
-#define GIC_CPU_BINPOINT		0x08
-#define GIC_CPU_INTACK			0x0c
-#define GIC_CPU_EOI			0x10
-#define GIC_CPU_RUNNINGPRI		0x14
-#define GIC_CPU_HIGHPRI			0x18
-
-#define GIC_DIST_CTRL			0x000
 #define GIC_DIST_CTR			0x004
-#define GIC_DIST_ENABLE_SET		0x100
-#define GIC_DIST_ENABLE_CLEAR		0x180
-#define GIC_DIST_PENDING_SET		0x200
-#define GIC_DIST_PENDING_CLEAR		0x280
-#define GIC_DIST_ACTIVE_BIT		0x300
-#define GIC_DIST_PRI			0x400
-#define GIC_DIST_TARGET			0x800
-#define GIC_DIST_CONFIG			0xc00
-#define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
 #include <linux/irqdomain.h>
-- 
1.7.9.5
