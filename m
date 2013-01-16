From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:00:41 -0500
Subject: [PATCH v6 04/13] ARM: gic: define GICH offsets for VGIC support
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180041.29393.48988.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The GICH_* constants are defined by the GIC HW spec, and even though
they only be used by KVM to begin with, define them generically in gic.h.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/hardware/gic.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index caf5df3..6cad421 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -34,6 +34,31 @@
 #define GIC_DIST_CONFIG			0xc00
 #define GIC_DIST_SOFTINT		0xf00
 
+#define GICH_HCR			0x0
+#define GICH_VTR			0x4
+#define GICH_VMCR			0x8
+#define GICH_MISR			0x10
+#define GICH_EISR0 			0x20
+#define GICH_EISR1 			0x24
+#define GICH_ELRSR0 			0x30
+#define GICH_ELRSR1 			0x34
+#define GICH_APR			0xf0
+#define GICH_LR0			0x100
+
+#define GICH_HCR_EN			(1 << 0)
+#define GICH_HCR_UIE			(1 << 1)
+
+#define GICH_LR_VIRTUALID		(0x3ff << 0)
+#define GICH_LR_PHYSID_CPUID_SHIFT	(10)
+#define GICH_LR_PHYSID_CPUID		(7 << GICH_LR_PHYSID_CPUID_SHIFT)
+#define GICH_LR_STATE			(3 << 28)
+#define GICH_LR_PENDING_BIT		(1 << 28)
+#define GICH_LR_ACTIVE_BIT		(1 << 29)
+#define GICH_LR_EOI			(1 << 19)
+
+#define GICH_MISR_EOI			(1 << 0)
+#define GICH_MISR_U			(1 << 1)
+
 #ifndef __ASSEMBLY__
 #include <linux/irqdomain.h>
 struct device_node;
