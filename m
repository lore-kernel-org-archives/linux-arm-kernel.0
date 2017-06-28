From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:34 +0100
Subject: [PATCH v2 15/52] irqchip/gic-v3-its: Add GICv4 ITS command definitions
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-16-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new GICv4 ITS command definitions, most of them, being
defined in terms of their physical counterparts.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqchip/arm-gic-v3.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index af8c55105fc2..7c6fd8f3e36c 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -348,6 +348,18 @@
 #define GITS_CMD_SYNC			0x05
 
 /*
+ * GICv4 ITS specific commands
+ */
+#define GITS_CMD_GICv4(x)		((x) | 0x20)
+#define GITS_CMD_VINVALL		GITS_CMD_GICv4(GITS_CMD_INVALL)
+#define GITS_CMD_VMAPP			GITS_CMD_GICv4(GITS_CMD_MAPC)
+#define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
+#define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
+#define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
+/* VMOVP is the odd one, as it doesn't have a physical counterpart */
+#define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
+
+/*
  * ITS error numbers
  */
 #define E_ITS_MOVI_UNMAPPED_INTERRUPT		0x010107
-- 
2.11.0
